// -- IMPORTS

import std.algorithm;
import std.conv;
import std.exception;
import std.stdio;
import std.typecons;

// -- CONSTANTS

enum int
    minimumPassCount = 0,
    maximumPassCount = 5;

// -- TYPES

class Being
{
    // -- ATTRIBUTES

    string
        name;
    int
        age;

    // -- CONSTRUCTORS

    this(
        string name,
        int age
        )
    {
        this.name = name;
        this.age = age;
    }
}

// ~~

class Person:
    Being
{
    // -- ATTRIBUTES

    double
        weight,
        dogCount;

    // -- CONSTRUCTORS

    this(
        string name,
        int age,
        double weight,
        double dogCount
        )
    {
        super( name, age );
        this.weight = weight;
        this.dogCount = dogCount;
    }

    // -- INQUIRIES

    int getAge(
        )
    {
        return age;
    }

    // ~~

    int getAgeOffset(
        int otherAge
        )
    {
        return otherAge - age;
    }

    // ~~

    string getHelloMessage(
        )
    {
        return "Hello, my name is %s, I'm %s years old and I weight %s kilograms."
            .format( name, age, weight );
    }

    // -- OPERATIONS

    void setAge(
        int age
        )
    {
        this.age = age;
    }

    // ~~

    void setFakeAge(
        int age
        )
    {
        if ( age > 0
             && age < 50
             && ( age < 20
                  || age > 40 ) )
        {
            this.age
                += ( age
                     + ( age - 2 )
                     + ( age
                         * ( age + 10 )
                         * ( age + 20 ) ) )
                   + this.getAgeOffset(
                         age * 2
                         - 20
                         );
        }
        else if ( age > 20
                  && age < 40
                  && ( age < 25
                       || age > 35 ) )
        {
            this.age = cast( int )( age * 0.5 + 0.5 );
        }
        else
        {
            this.age = age + 10;
        }
    }
}

// -- FUNCTIONS

Nullable!( int[ string ] ) getAgeInterval(
    Person[] sortedPersonArray
    )
{
    if ( sortedPersonArray.length == 0 )
    {
        return Nullable!( int[ string ] ).init;
    }
    else
    {
        int[ string ] ageInterval
            = [
                "firstAge": sortedPersonArray[ 0 ].age,
                "lastAge": sortedPersonArray[ sortedPersonArray.length - 1 ].age
            ];

        return Nullable!( int[ string ] )( ageInterval );
    }
}

// ~~

void main(
    )
{
    auto passIndex = 0;

    while ( passIndex < 5 )
    {
        ++passIndex;
    }

    do
    {
        ++passIndex;
    }
    while ( passIndex < 10 );

    Person[] personArray
        = [
            new Person( "Mike", 49, 85, 1 ),
            new Person( "Luke", 30, 77, 0 ),
            new Person( "John", 30, 72, 3 )
        ];

    personArray.sort!(
        ( firstPerson, secondPerson )
        {
            try
            {
                if ( firstPerson.age != secondPerson.age )
                {
                    return firstPerson.age < secondPerson.age;
                }
                else
                {
                    return firstPerson.weight < secondPerson.weight;
                }
            }
            catch ( Exception error )
            {
                writeln( error.toString() );
            }

            return false;
        }
        )();

    auto ageInterval = getAgeInterval( personArray );

    if ( !ageInterval.isNull )
    {
        writeln( "First age: ", ageInterval.get[ "firstAge" ] );
        writeln( "Last age: ", ageInterval.get[ "lastAge" ] );
    }
    else
    {
        writeln( "No age interval" );
    }
}
```
%% language=Dart
```dart
// -- IMPORTS

import 'dart:core';

// -- CONSTANTS

const int
    minimumPassCount = 0,
    maximumPassCount = 5;

// -- TYPES

class Being
{
    // -- ATTRIBUTES

    String
        name;
    int
        age;

    // -- CONSTRUCTORS

    Being(
        this.name,
        this.age
        );
}

// ~~

class Person
    extends Being
{
    // -- ATTRIBUTES

    double
        weight,
        dogCount;

    // -- CONSTRUCTORS

    Person(
        String name,
        int age,
        this.weight,
        this.dogCount
        ):
        super( name, age );

    // -- INQUIRIES

    int getAge(
        )
    {
        return age;
    }

    // ~~

    int getAgeOffset(
        int otherAge
        )
    {
        return otherAge - age;
    }

    // ~~

    String getHelloMessage(
        )
    {
        return 'Hello, my name is ${ name }, I\'m ${ age } years old and I weight ${ weight } kilograms.';
    }

    // -- OPERATIONS

    void setAge(
        int age
        )
    {
        this.age = age;
    }

    // ~~

    void setFakeAge(
        int age
        )
    {
        if ( age > 0
             && age < 50
             && ( age < 20
                  || age > 40 ) )
        {
            this.age
                += ( age
                     + ( age - 2 )
                     + ( age
                         * ( age + 10 )
                         * ( age + 20 ) ) )
                   + this.getAgeOffset(
                         age * 2
                         - 20
                         );
        }
        else if ( age > 20
                  && age < 40
                  && ( age < 25
                       || age > 35 ) )
        {
            this.age = ( age * 0.5 ).round();
        }
        else
        {
            this.age = age + 10;
        }
    }
}

// -- FUNCTIONS

Map<String, int>? getAgeInterval(
    List<Person> sortedPersonList
    )
{
    if ( sortedPersonList.isEmpty )
    {
        return null;
    }
    else
    {
        return
            {
                'firstAge': sortedPersonList[ 0 ].age,
                'lastAge': sortedPersonList[ sortedPersonList.length - 1 ].age
            };
    }
}

// ~~

void main(
    )
{
    var passIndex = 0;

    while ( passIndex < 5 )
    {
        ++passIndex;
    }

    do
    {
        ++passIndex;
    }
    while ( passIndex < 10 );

    var personList
        = [
            Person( 'Mike', 49, 85, 1 ),
            Person( 'Luke', 30, 77, 0 ),
            Person( 'John', 30, 72, 3 )
        ];

    personList.sort(
        ( firstPerson, secondPerson )
        {
            try
            {
                if ( firstPerson.age != secondPerson.age )
                {
                    return firstPerson.age - secondPerson.age;
                }
                else
                {
                    return firstPerson.weight.compareTo( secondPerson.weight );
                }
            }
            catch ( error )
            {
                print( error.toString() );
            }

            return 0;
        }
        );

    var ageInterval = getAgeInterval( personList );

    if ( ageInterval != null )
    {
        print( 'First age: ${ ageInterval[ 'firstAge' ] }' );
        print( 'Last age: ${ ageInterval[ 'lastAge' ] }' );
    }
    else
    {
        print( 'No age interval' );
    }
}
