// -- IMPORTS

#include "Engine/Core/Common.h"
#include "Engine/Core/Collections/Dictionary.h"
#include "Engine/Core/Log.h"

// -- CONSTANTS

constexpr int32
    MinimumPassCount = 0,
    MaximumPassCount = 5;

// -- TYPES

class Being
{
    // == PUBLIC

    public:

    // -- ATTRIBUTES

    String
        Name;
    int32
        Age;

    // -- CONSTRUCTORS

    Being(
        String name,
        int32 age
        )
    {
        Name = name;
        Age = age;
    }
};

// ~~

class Person:
    public Being
{
    // == PUBLIC

    public:

    // -- ATTRIBUTES

    double
        Weight,
        DogCount;

    // -- CONSTRUCTORS

    Person(
        String name,
        int32 age,
        double weight,
        double dogCount
        ):
        Being( name, age )
    {
        Weight = weight;
        DogCount = dogCount;
    }

    // -- INQUIRIES

    int32 GetAge(
        )
    {
        return Age;
    }

    // ~~

    int32 GetAgeOffset(
        int32 otherAge
        )
    {
        return otherAge - Age;
    }

    // ~~

    String GetHelloMessage(
        )
    {
        return
            String::Format(
                TEXT( "Hello, my name is {0}, I'm {1} years old and I weight {2} kilograms." ),
                Name,
                Age,
                Weight
                );
    }

    // -- OPERATIONS

    void SetAge(
        int32 age
        )
    {
        Age = age;
    }

    // ~~

    void SetFakeAge(
        int32 age
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
            Age = Math::Round( (double)age * 0.5 );
        }
        else
        {
            Age = age + 10;
        }
    }
};

// -- FUNCTIONS

Dictionary<String, int32>* GetAgeInterval(
    const Array<Person>& sortedPersonArray
    )
{
    if ( sortedPersonArray.Count() == 0 )
    {
        return nullptr;
    }
    else
    {
        auto ageIntervalDictionary = new Dictionary<String, int32>();

        ageIntervalDictionary->Add(
            TEXT( "firstAge" ),
            sortedPersonArray[ 0 ].Age
            );

        ageIntervalDictionary->Add(
            TEXT( "lastAge" ),
            sortedPersonArray[ sortedPersonArray.Count() - 1 ].Age
            );

        return ageIntervalDictionary;
    }
}

// ~~

void Main(
    )
{
    int32 passIndex = 0;

    while ( passIndex < 5 )
    {
        ++passIndex;
    }

    do
    {
        ++passIndex;
    }
    while ( passIndex < 10 );

    Array<Person> personArray;

    personArray.Add( Person( TEXT( "Mike" ), 49, 85, 1 ) );
    personArray.Add( Person( TEXT( "Luke" ), 30, 77, 0 ) );
    personArray.Add( Person( TEXT( "John" ), 30, 72, 3 ) );

    personArray.Sort(
        []( const Person& firstPerson, const Person& secondPerson )
        {
            try
            {
                if ( firstPerson.Age != secondPerson.Age )
                {
                    return firstPerson.Age - secondPerson.Age;
                }
                else
                {
                    return (int32)Math::Sign( firstPerson.Weight - secondPerson.Weight );
                }
            }
            catch ( const Exception& error )
            {
                LOG( Error, error.ToString() );
            }

            return 0;
        }
        );

    auto ageIntervalDictionary = GetAgeInterval( personArray );

    if ( ageIntervalDictionary != nullptr )
    {
        LOG(
            Info,
            TEXT( "First age: {0}" ),
            ageIntervalDictionary->At( TEXT( "firstAge" ) )
            );

        LOG(
            Info,
            TEXT( "Last age: {0}" ),
            ageIntervalDictionary->At( TEXT( "lastAge" ) )
            );
    }
    else
    {
        LOG( Info, TEXT( "No age interval" ) );
    }
}
