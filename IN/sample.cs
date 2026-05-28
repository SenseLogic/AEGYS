// -- IMPORTS

using System;
using System.Collections.Generic;

// -- CONSTANTS

public static class SampleConstants
{
    public const int
        MinimumPassCount = 0,
        MaximumPassCount = 5;
}

// -- TYPES

public class Being
{
    // -- ATTRIBUTES

    public string
        Name;
    public int
        Age;

    // -- CONSTRUCTORS

    public Being(
        string name,
        int age
        )
    {
        Name = name;
        Age = age;
    }
}

// ~~

public class Person:
    Being
{
    // -- ATTRIBUTES

    public double
        Weight,
        DogCount;

    // -- CONSTRUCTORS

    public Person(
        string name,
        int age,
        double weight,
        double dogCount
        ):
        base( name, age )
    {
        Weight = weight;
        DogCount = dogCount;
    }

    // -- INQUIRIES

    public int GetAge(
        )
    {
        return Age;
    }

    // ~~

    public int GetAgeOffset(
        int otherAge
        )
    {
        return otherAge - Age;
    }

    // ~~

    public string GetHelloMessage(
        )
    {
        return $"Hello, my name is { Name }, I'm { Age } years old and I weight { Weight } kilograms.";
    }

    // -- OPERATIONS

    public void SetAge(
        int age
        )
    {
        Age = age;
    }

    // ~~

    public void SetFakeAge(
        int age
        )
    {
        if ( age > 0
             && age < 50
             && ( age < 20
                  || age > 40 ) )
        {
            Age
                += ( age
                     + ( age - 2 )
                     + ( age
                         * ( age + 10 )
                         * ( age + 20 ) ) )
                   + GetAgeOffset(
                         age * 2
                         - 20
                         );
        }
        else if ( age > 20
                  && age < 40
                  && ( age < 25
                       || age > 35 ) )
        {
            Age = (int)Math.Round( age * 0.5, MidpointRounding.AwayFromZero );
        }
        else
        {
            Age = age + 10;
        }
    }
}

// -- FUNCTIONS

public static class SampleFunctions
{
    public static Dictionary<string, int>? GetAgeInterval(
        List<Person> sortedPersonList
        )
    {
        if ( sortedPersonList.Count == 0 )
        {
            return null;
        }
        else
        {
            return new Dictionary<string, int>
            {
                { "firstAge", sortedPersonList[ 0 ].Age },
                { "lastAge", sortedPersonList[ sortedPersonList.Count - 1 ].Age }
            };
        }
    }
}

// ~~

public static class Program
{
    public static void Main(
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
            = new List<Person>
            {
                new Person( "Mike", 49, 85, 1 ),
                new Person( "Luke", 30, 77, 0 ),
                new Person( "John", 30, 72, 3 )
            };

        personList.Sort(
            ( firstPerson, secondPerson ) =>
            {
                try
                {
                    if ( firstPerson.Age != secondPerson.Age )
                    {
                        return firstPerson.Age - secondPerson.Age;
                    }
                    else
                    {
                        return firstPerson.Weight.CompareTo( secondPerson.Weight );
                    }
                }
                catch ( Exception error )
                {
                    Console.WriteLine( error.ToString() );
                }

                return 0;
            }
            );

        var ageInterval = SampleFunctions.GetAgeInterval( personList );

        if ( ageInterval != null )
        {
            Console.WriteLine( $"First age: { ageInterval[ "firstAge" ] }" );
            Console.WriteLine( $"Last age: { ageInterval[ "lastAge" ] }" );
        }
        else
        {
            Console.WriteLine( "No age interval" );
        }
    }
}
