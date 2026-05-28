package main;

// -- IMPORTS

import (
    "fmt"
    "sort"
    );

// -- CONSTANTS

const (
    MinimumPassCount = 0,
    MaximumPassCount = 5
    );

// -- TYPES

type Being struct
{
    // -- ATTRIBUTES

    Name string;
    Age int;
}

// ~~

type Person struct
{
    // -- ATTRIBUTES

    Being;
    Weight float64;
    DogCount float64;
}

// -- CONSTRUCTORS

func NewBeing(
    name string,
    age int
    ) Being
{
    return Being
    {
        Name: name,
        Age: age
    };
}

// ~~

func NewPerson(
    name string,
    age int,
    weight float64,
    dogCount float64
    ) Person
{
    return Person
    {
        Being: NewBeing( name, age ),
        Weight: weight,
        DogCount: dogCount
    };
}

// -- INQUIRIES

func ( person Person ) GetAge(
    ) int
{
    return person.Age;
}

// ~~

func ( person Person ) GetAgeOffset(
    otherAge int
    ) int
{
    return otherAge - person.Age;
}

// ~~

func ( person Person ) GetHelloMessage(
    ) string
{
    return (
        fmt.Sprintf(
            "Hello, my name is %s, I'm %d years old and I weight %f kilograms.",
            person.Name,
            person.Age,
            person.Weight
            )
        );
}

// -- OPERATIONS

func ( person *Person ) SetAge(
    age int
    )
{
    person.Age = age;
}

// ~~

func ( person *Person ) SetFakeAge(
    age int
    )
{
    if ( age > 0
         && age < 50
         && ( age < 20
              || age > 40 ) )
    {
        person.Age
            += ( age
                 + ( age - 2 )
                 + ( age
                     * ( age + 10 )
                     * ( age + 20 ) ) )
               + person.GetAgeOffset(
                     age * 2
                     - 20
                     );
    }
    else if ( age > 20
              && age < 40
              && ( age < 25
                   || age > 35 ) )
    {
        person.Age = int( float64( age ) * 0.5 + 0.5 );
    }
    else
    {
        person.Age = age + 10;
    }
}

// -- FUNCTIONS

func GetAgeInterval(
    sortedPersonSlice []Person
    ) map[string]int
{
    if ( len( sortedPersonSlice ) == 0 )
    {
        return nil;
    }
    else
    {
        return map[string]int
        {
            "firstAge": sortedPersonSlice[ 0 ].Age,
            "lastAge": sortedPersonSlice[ len( sortedPersonSlice ) - 1 ].Age
        };
    }
}

// ~~

func main(
    )
{
    passIndex := 0;

    for passIndex < 5
    {
        passIndex++;
    }

    for
    {
        passIndex++;

        if ( passIndex >= 10 )
        {
            break;
        }
    }

    personSlice
        := []Person
            {
                NewPerson( "Mike", 49, 85, 1 ),
                NewPerson( "Luke", 30, 77, 0 ),
                NewPerson( "John", 30, 72, 3 )
            };

    sort.Slice(
        personSlice,
        func(
            firstPersonIndex int,
            secondPersonIndex int
            ) bool
        {
            firstPerson := personSlice[ firstPersonIndex ];
            secondPerson := personSlice[ secondPersonIndex ];

            if ( firstPerson.Age != secondPerson.Age )
            {
                return firstPerson.Age < secondPerson.Age;
            }
            else
            {
                return firstPerson.Weight < secondPerson.Weight;
            }
        }
        );

    ageInterval := GetAgeInterval( personSlice );

    if ( ageInterval != nil )
    {
        fmt.Println(
            fmt.Sprintf(
                "First age: %d",
                ageInterval[ "firstAge" ]
                )
            );

        fmt.Println(
            fmt.Sprintf(
                "Last age: %d",
                ageInterval[ "lastAge" ]
                )
            );
    }
    else
    {
        fmt.Println( "No age interval" );
    }
}
