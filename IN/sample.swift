// -- CONSTANTS

let
    minimumPassCount = 0,
    maximumPassCount = 5;

// -- TYPES

class Being
{
    // -- PROPERTIES

    var name: String;
    var age: Int;

    // -- CONSTRUCTORS

    init(
        _ name: String,
        _ age: Int
        )
    {
        self.name = name;
        self.age = age;
    }
}

// ~~

final class Person
    : Being
{
    // -- PROPERTIES

    var weight: Int;
    var dogCount: Int;

    // -- CONSTRUCTORS

    init(
        _ name: String,
        _ age: Int,
        _ weight: Int,
        _ dogCount: Int
        )
    {
        self.weight = weight;
        self.dogCount = dogCount;
        super.init( name, age );
    }

    // -- INQUIRIES

    func getAge(
        ) -> Int
    {
        return self.age;
    }

    // ~~

    func getAgeOffset(
        _ otherAge: Int
        ) -> Int
    {
        return otherAge - self.age;
    }

    // ~~

    func getHelloMessage(
        )
        -> String
    {
        return "Hello, my name is \( self.name ), I'm \( self.age ) years old and I weight \( self.weight ) kilograms.";
    }

    // -- OPERATIONS

    func setAge(
        _ age: Int
        )
    {
        self.age = age;
    }

    // ~~

    func setFakeAge(
        _ age: Int
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
            self.age = Int( ( Double( age ) * 0.5 ).rounded() );
        }
        else
        {
            self.age = age + 10;
        }
    }
}

// -- FUNCTIONS

struct AgeInterval
{
    let firstAge: Int;
    let lastAge: Int;
}

// ~~

func getAgeInterval(
    _ sortedPersonArray: [ Person ]
    )
    -> AgeInterval?
{
    if ( sortedPersonArray.isEmpty )
    {
        return nil;
    }
    else
    {
        return AgeInterval(
            firstAge: sortedPersonArray[ 0 ].age,
            lastAge: sortedPersonArray[ sortedPersonArray.count - 1 ].age
            );
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
        : [ Person ]
        = [
            Person( "Mike", 49, 85, 1 ),
            Person( "Luke", 30, 77, 0 ),
            Person( "John", 30, 72, 3 )
        ];

    personArray.sort(
        by:
        {
            firstPerson,
            secondPerson
            in

            if ( firstPerson.age != secondPerson.age )
            {
                return firstPerson.age < secondPerson.age;
            }
            else
            {
                return firstPerson.weight < secondPerson.weight;
            }
        }
        );

    let ageInterval = getAgeInterval( personArray );

    if ( ageInterval != nil )
    {
        print( "First age: \( ageInterval!.firstAge )" );
        print( "Last age: \( ageInterval!.lastAge )" );
    }
    else
    {
        print( "No age interval" );
    }
}

// -- STATEMENTS

main();
