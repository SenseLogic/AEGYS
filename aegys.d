/*
    This file is part of the Aegys distribution.

    https://github.com/SenseLogic/AEGYS

    Copyright (C) 2026 Eric Pelzer (ecstatic.coder@gmail.com)

    Aegys is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, version 3.

    Aegys is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Aegys.  If not, see <http://www.gnu.org/licenses/>.
*/

// -- IMPORTS

import core.stdc.stdlib : exit;
import std.algorithm : countUntil;
import std.conv : to;
import std.file : exists, mkdirRecurse, readText, write;
import std.path : absolutePath;
import std.stdio : writeln;
import std.string : indexOf, join, lastIndexOf, replace, split, startsWith, stripRight;

// -- FUNCTIONS

void PrintError(
    string message
    )
{
    writeln( "*** ERROR : ", message );
}

// ~~

void Abort(
    string message
    )
{
    PrintError( message );

    exit( -1 );
}

// ~~

void Abort(
    string message,
    Exception exception
    )
{
    PrintError( message );
    PrintError( exception.msg );

    exit( -1 );
}

// ~~

string[] SplitOnce(
    string text,
    char separator_character
    )
{
    long
        separator_character_index;

    separator_character_index = text.indexOf( separator_character );

    if ( separator_character_index >= 0 )
    {
        return [ text[ 0 .. separator_character_index ], text[ separator_character_index + 1 .. $ ] ];
    }
    else
    {
        return [ text ];
    }
}

// ~~

string GetPhysicalPath(
    string path
    )
{
    version( Windows )
    {
        return `\\?\` ~ path.absolutePath.replace( '/', '\\' ).replace( "\\.\\", "\\" );
    }

    return path;
}

// ~~

string GetLogicalPath(
    string path
    )
{
    return path.replace( '\\', '/' );
}

// ~~

string GetFolderPath(
    string file_path
    )
{
    long
        slash_character_index;

    slash_character_index = file_path.lastIndexOf( '/' );

    if ( slash_character_index >= 0 )
    {
        return file_path[ 0 .. slash_character_index + 1 ];
    }
    else
    {
        return "";
    }
}

// ~~

string GetFileName(
    string file_path
    )
{
    long
        slash_character_index;

    slash_character_index = file_path.lastIndexOf( '/' );

    if ( slash_character_index >= 0 )
    {
        return file_path[ slash_character_index + 1 .. $ ];
    }
    else
    {
        return file_path;
    }
}

// ~~

void CreateFolder(
    string folder_path
    )
{
    try
    {
        if ( folder_path != ""
             && folder_path != "/"
             && !folder_path.exists() )
        {
            writeln( "Creating folder : ", folder_path );

            folder_path.GetPhysicalPath().mkdirRecurse();
        }
    }
    catch ( Exception exception )
    {
        Abort( "Can't create folder : " ~ folder_path, exception );
    }
}

// ~~

void WriteText(
    string file_path,
    string file_text
    )
{
    CreateFolder( file_path.GetFolderPath() );

    try
    {
        writeln( "Writing file : ", file_path );

        file_path.write( file_text );
    }
    catch ( Exception exception )
    {
        Abort( "Can't write file : " ~ file_path, exception );
    }
}

// ~~

string ReadText(
    string file_path
    )
{
    string
        file_text;

    writeln( "Reading file : ", file_path );

    try
    {
        file_text = file_path.readText();
    }
    catch ( Exception exception )
    {
        Abort( "Can't read file : " ~ file_path, exception );
    }

    return file_text;
}

// ~~

bool GetVariableExpressionValue(
    string expression,
    string[ string ] variable_value_by_name_map
    )
{
    string
        variable_name,
        variable_value;
    string*
        variable_value_by_name;
    string[]
        part_array;

    part_array = expression.SplitOnce( '=' );

    variable_name = part_array[ 0 ];
    variable_value = ( part_array.length == 2 ) ? part_array[ 1 ] : "";
    variable_value_by_name = variable_name in variable_value_by_name_map;

    if ( part_array.length == 1 )
    {
        return variable_value_by_name !is null;
    }
    else
    {
        if ( variable_value_by_name is null )
        {
            return false;
        }
        else
        {
            return *variable_value_by_name == variable_value.ReplaceVariables( variable_value_by_name_map );
        }
    }
}

// ~~

bool GetBooleanExpressionValue(
    string expression,
    string[ string ] variable_value_by_name_map
    )
{
    long
        valid_sub_condition_count;
    string[]
        condition_array,
        sub_condition_array;

    condition_array = expression.split( " | " );

    foreach ( condition; condition_array )
    {
        sub_condition_array = condition.split( " & " );

        valid_sub_condition_count = 0;

        foreach ( sub_condition; sub_condition_array )
        {
            if ( ( !sub_condition.startsWith( '!' )
                   && GetVariableExpressionValue( sub_condition, variable_value_by_name_map ) )
                 || ( sub_condition.startsWith( '!' )
                      && !GetVariableExpressionValue( sub_condition[ 1 .. $ ], variable_value_by_name_map ) ) )
            {
                ++valid_sub_condition_count;
            }
            else
            {
                break;
            }
        }

        if ( valid_sub_condition_count == sub_condition_array.length )
        {
            return true;
        }
    }

    return false;
}

// ~~

string ReplaceVariables(
    string text,
    string[ string ] variable_value_by_name_map
    )
{
    foreach ( variable_name, variable_value; variable_value_by_name_map )
    {
        text = text.replace( "{" ~ variable_name ~ "}", variable_value );
    }

    return text;
}

// ~~

void AssignVariable(
    string variable_definition,
    ref string[ string ] variable_value_by_name_map
    )
{
    string
        variable_name,
        variable_value;
    string[]
        part_array,
        variable_definition_array;

    part_array = variable_definition.SplitOnce( '=' );

    variable_name = part_array[ 0 ];
    variable_value = ( part_array.length == 2 ) ? part_array[ 1 ] : "";
    variable_value_by_name_map[ variable_name ] = ReplaceVariables( variable_value, variable_value_by_name_map );
}

// ~~

string[ string ] GetVariableValueByNameMap(
    string source_file_configuration
    )
{
    string[]
        variable_definition_array;
    string[ string ]
        variable_value_by_name_map;

    variable_definition_array = source_file_configuration.split( ' ' );

    foreach ( variable_definition; variable_definition_array )
    {
        AssignVariable( variable_definition.replace( '^', ' ' ), variable_value_by_name_map );
    }

    return variable_value_by_name_map;
}

// ~~

string GetIncludedFilePath(
    string source_folder_path,
    string included_file_path
    )
{
    if ( included_file_path.indexOf( ':' ) >= 0
         || included_file_path.startsWith( '/' ) )
    {
        return included_file_path;
    }
    else if ( included_file_path.startsWith( "./" ) )
    {
        return source_folder_path ~ included_file_path[ 2 .. $ ];
    }
    else
    {
        return source_folder_path ~ included_file_path;
    }
}

// ~~

string GetProcessedFileText(
    string source_file_path,
    string source_file_configuration
    )
{
    bool[]
        condition_array;
    long
        source_line_index;
    string
        included_file_path,
        included_text,
        source_line,
        source_file_text;
    string[]
        included_line_array,
        processed_line_array,
        source_line_array;
    string[ string ]
        variable_value_by_name_map;

    variable_value_by_name_map = GetVariableValueByNameMap( source_file_configuration );

    source_file_text = source_file_path.ReadText();
    source_line_array = source_file_text.replace( "\r", "" ).split( '\n' );

    for ( source_line_index = 0;
          source_line_index < source_line_array.length;
          ++source_line_index )
    {
        source_line_array[ source_line_index ] = source_line_array[ source_line_index ].stripRight();
    }

    source_file_text = "";
    condition_array = [ true, true, true ];

    for ( source_line_index = 0;
          source_line_index < source_line_array.length;
          ++source_line_index )
    {
        source_line = source_line_array[ source_line_index ];

        if ( source_line == "%%" )
        {
            condition_array = [ true, true, true ];
        }
        else if ( source_line.startsWith( "%% " ) )
        {
            condition_array = [ source_line[ 3 .. $ ].GetBooleanExpressionValue( variable_value_by_name_map ), true, true ];
        }
        else if ( source_line == "%%%" )
        {
            condition_array[ 1 ] = true;
            condition_array[ 2 ] = true;
        }
        else if ( source_line.startsWith( "%%% " ) )
        {
            condition_array[ 1 ] = source_line[ 4 .. $ ].GetBooleanExpressionValue( variable_value_by_name_map );
            condition_array[ 2 ] = true;
        }
        else if ( source_line == "%%%%" )
        {
            condition_array[ 3 ] = true;
        }
        else if ( source_line.startsWith( "%%%% " ) )
        {
            condition_array[ 3 ] = source_line[ 5 .. $ ].GetBooleanExpressionValue( variable_value_by_name_map );
        }
        else
        {
            if ( condition_array[ 0 ]
                 && condition_array[ 1 ]
                 && condition_array[ 2 ] )
            {
                if ( source_line.startsWith( "%? " ) )
                {
                    writeln( source_line[ 3 .. $ ].ReplaceVariables( variable_value_by_name_map ) );
                }
                else if ( source_line.startsWith( "%@ " ) )
                {
                    included_file_path
                        = GetIncludedFilePath(
                              source_file_path.GetFolderPath(),
                              source_line[ 3 .. $ ].ReplaceVariables( variable_value_by_name_map ).GetLogicalPath()
                              );
                    included_text = included_file_path.ReadText();
                    included_line_array = included_text.replace( "\r", "" ).split( '\n' );

                    source_line_array
                        = source_line_array[ 0 .. source_line_index ]
                          ~ included_line_array
                          ~ source_line_array[ source_line_index + 1 .. $ ];

                    --source_line_index;
                }
                else if ( source_line.startsWith( "%: " ) )
                {
                    AssignVariable( source_line[ 3 .. $ ], variable_value_by_name_map );
                }
                else
                {
                    processed_line_array ~= source_line.ReplaceVariables( variable_value_by_name_map );
                }
            }
        }
    }

    return processed_line_array.join( '\n' );
}

// ~~

void main(
    string[] argument_array
    )
{
    long
        argument_count;
    string
        processed_file_text;

    argument_array = argument_array[ 1 .. $ ];
    argument_count = argument_array.length;

    if ( argument_count >= 3
         && argument_count & 1 )
    {
        while ( argument_array.length >= 2 )
        {
            processed_file_text
                ~= GetProcessedFileText(
                       argument_array[ 0 ].GetLogicalPath(),
                       argument_array[ 1 ]
                       );

            argument_array = argument_array[ 2 .. $ ];
        }

        WriteText(
            argument_array[ 0 ].GetLogicalPath(),
            processed_file_text
            );
    }
    else
    {
        writeln( "Usage :" );
        writeln( "    aegys <source_file_path> <source_file_configuration> [<source_file_path> <source_file_configuration> ...] <target_file_path>" );

        PrintError( "Invalid arguments : " ~ argument_array.to!string() );
    }
}
