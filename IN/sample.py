# -- IMPORTS

from functools import cmp_to_key;
from typing import TypedDict;

# -- CONSTANTS

minimumPassCount = 0;
maximumPassCount = 5;

# -- TYPES

class AgeInterval( TypedDict ):

    firstAge: int;
    lastAge: int;

# ~~

class Being:

    # -- CONSTRUCTORS

    def __init__(
        self,
        name,
        age
        ):

        self.name = name;
        self.age = age;

# ~~

class Person( Being ):

    # -- CONSTRUCTORS

    def __init__(
        self,
        name,
        age,
        weight,
        dogCount
        ):

        super().__init__( name, age );
        self.weight = weight;
        self.dogCount = dogCount;

    # -- INQUIRIES

    def getAge(
        self
        ) -> int:

        return self.age;

    # ~~

    def getAgeOffset(
        self,
        otherAge
        ) -> int:

        return otherAge - self.age;

    # ~~

    def getHelloMessage(
        self
        ) -> str:

        return f"Hello, my name is { self.name }, I'm { self.age } years old and I weight { self.weight } kilograms.";

    # -- OPERATIONS

    def setAge(
        self,
        age
        ) -> None:

        self.age = age;

    # ~~

    def setFakeAge(
        self,
        age
        ) -> None:

        if ( age > 0
             and age < 50
             and ( age < 20
                  or age > 40 ) ):

            self.age \
                += ( age
                     + ( age - 2 )
                     + ( age
                         * ( age + 10 )
                         * ( age + 20 ) ) ) \
                   + self.getAgeOffset(
                         age * 2
                         - 20
                         );

        elif ( age > 20
               and age < 40
               and ( age < 25
                    or age > 35 ) ):

            self.age = round( age * 0.5 );

        else:

            self.age = age + 10;

# -- FUNCTIONS

def getAgeInterval(
    sortedPersonArray
    ) -> AgeInterval | None:

    if len( sortedPersonArray ) == 0:

        return None;

    else:

        return (
            {
                'firstAge': sortedPersonArray[ 0 ].age,
                'lastAge': sortedPersonArray[ len( sortedPersonArray ) - 1 ].age
            }
            );

# ~~

def main(
    ) -> None:

    passIndex = 0;

    while passIndex < 5:

        passIndex += 1;

    while True:

        passIndex += 1;

        if passIndex >= 10:

            break;

    personArray \
        = [
              Person( 'Mike', 49, 85, 1 ),
              Person( 'Luke', 30, 77, 0 ),
              Person( 'John', 30, 72, 3 )
          ];

    def comparePerson(
        firstPerson,
        secondPerson
        ):

        try:

            if firstPerson.age != secondPerson.age:

                return firstPerson.age - secondPerson.age;

            else:

                return firstPerson.weight - secondPerson.weight;

        except Exception as error:

            print( str( error ) );

        return 0;

    personArray.sort(
        key=cmp_to_key( comparePerson )
        );

    ageInterval = getAgeInterval( personArray );

    if ageInterval is not None:

        print( f"First age: { ageInterval[ 'firstAge' ] }" );
        print( f"Last age: { ageInterval[ 'lastAge' ] }" );

    else:

        print( 'No age interval' );

# -- STATEMENTS

main();
```
%% language=Swift
```swift
// -- IMPORTS

import Foundation

// -- CONSTANTS

let minimumPassCount: Int = 0;
let maximumPassCount: Int = 5;

// -- TYPES

class Being
{
    // -- ATTRIBUTES

    var name: String;
    var age: Int;

    // -- CONSTRUCTORS

    init(
        name: String,
        age: Int
        )
    {
        self.name = name;
        self.age = age;
    }
}

// ~~

class Person: Being
{
    // -- ATTRIBUTES

    var weight: Double;
    var dogCount: Double;

    // -- CONSTRUCTORS

    init(
        name: String,
        age: Int,
        weight: Double,
        dogCount: Double
        )
    {
        super.init(
            name: name,
            age: age
            );
        self.weight = weight;
        self.dogCount = dogCount;
    }

    // -- INQUIRIES

    func getAge(
        ) -> Int
    {
        return age;
    }

    // ~~

    func getAgeOffset(
        otherAge: Int
        ) -> Int
    {
        return otherAge - age;
    }

    // ~~

    func getHelloMessage(
        ) -> String
    {
        return "Hello, my name is \( name ), I'm \( age ) years old and I weight \( weight ) kilograms.";
    }

    // -- OPERATIONS

    func setAge(
        age: Int
        )
    {
        self.age = age;
    }

    // ~~

    func setFakeAge(
        age: Int
        )
    {
        if ( age > 0
             && age < 50
             && ( age < 20
                  || age > 40 ) )
        {
            self.age
                += ( age
                     + ( age - 2 )
                     + ( age
                         * ( age + 10 )
                         * ( age + 20 ) ) )
                   + self.getAgeOffset(
                         age * 2
                         - 20
                         );
        }
        else if ( age > 20
                  && age < 40
                  && ( age < 25
                       || age > 35 ) )
        {
            self.age = Int( Double( age ) * 0.5 );
        }
        else
        {
            self.age = age + 10;
        }
    }
}

// -- FUNCTIONS

func getAgeInterval(
    sortedPersonArray: [Person]
    ) -> [String: Int]?
{
    if ( sortedPersonArray.isEmpty )
    {
        return nil;
    }
    else
    {
        return
            [
                "firstAge": sortedPersonArray[ 0 ].age,
                "lastAge": sortedPersonArray[ sortedPersonArray.count - 1 ].age
            ];
    }
}

// ~~

func main(
    )
{
    var passIndex = 0;

    while ( passIndex < 5 )
    {
        passIndex += 1;
    }

    repeat
    {
        passIndex += 1;
    }
    while ( passIndex < 10 );

    var personArray
        = [
            Person(
                name: "Mike",
                age: 49,
                weight: 85,
                dogCount: 1
                ),
            Person(
                name: "Luke",
                age: 30,
                weight: 77,
                dogCount: 0
                ),
            Person(
                name: "John",
                age: 30,
                weight: 72,
                dogCount: 3
                )
        ];

    personArray.sort(
        {
            firstPerson,
            secondPerson in

            do
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
            catch let error
            {
                print( error );
            }

            return false;
        }
        );

    let ageInterval = getAgeInterval( personArray );

    if ( ageInterval != nil )
    {
        print( "First age: \( ageInterval![ "firstAge" ]! )" );
        print( "Last age: \( ageInterval![ "lastAge" ]! )" );
    }
    else
    {
        print( "No age interval" );
    }
}

// -- STATEMENTS

main();
