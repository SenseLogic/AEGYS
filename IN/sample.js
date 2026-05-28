// -- CONSTANTS

const
    minimumPassCount = 0,
    maximumPassCount = 5;

// -- TYPES

class Being
{
    // -- CONSTRUCTORS

    constructor(
        name,
        age
        )
    {
        this.name = name;
        this.age = age;
    }
}

// ~~

class Person
    extends Being
{
    // -- CONSTRUCTORS

    constructor(
        name,
        age,
        weight,
        dogCount
        )
    {
        super( name, age );
        this.weight = weight;
        this.dogCount = dogCount;
    }

    // -- INQUIRIES

    getAge(
        )
    {
        return this.age;
    }

    // ~~

    getAgeOffset(
        otherAge
        )
    {
        return otherAge - this.age;
    }

    // ~~

    getHelloMessage(
        )
    {
        return `Hello, my name is ${ this.name }, I'm ${ this.age } years old and I weight ${ this.weight } kilograms.`;
    }

    // -- OPERATIONS

    setAge(
        age
        )
    {
        this.age = age;
    }

    // ~~

    setFakeAge(
        age
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
            this.age = Math.round( age * 0.5 );
        }
        else
        {
            this.age = age + 10;
        }
    }
}

// -- FUNCTIONS

function getAgeInterval(
    sortedPersonArray
    )
{
    if ( sortedPersonArray.length === 0 )
    {
        return null;
    }
    else
    {
        return (
            {
                firstAge: sortedPersonArray[ 0 ].age,
                lastAge: sortedPersonArray[ sortedPersonArray.length - 1 ].age
            }
            );
    }
}

// ~~

function main(
    )
{
    let passIndex = 0;

    while ( passIndex < 5 )
    {
        ++passIndex;
    }

    do
    {
        ++passIndex;
    }
    while ( passIndex < 10 );

    let personArray
        = [
            new Person( 'Mike', 49, 85, 1 ),
            new Person( 'Luke', 30, 77, 0 ),
            new Person( 'John', 30, 72, 3 )
        ];

    personArray.sort(
        ( firstPerson, secondPerson ) =>
        {
            try
            {
                if ( firstPerson.age !== secondPerson.age )
                {
                    return firstPerson.age - secondPerson.age;
                }
                else
                {
                    return firstPerson.weight - secondPerson.weight;
                }
            }
            catch ( error )
            {
                console.log( error.toString() );
            }

            return 0;
        }
        );

    let ageInterval = getAgeInterval( personArray );

    if ( ageInterval !== null )
    {
        console.log( `First age: ${ ageInterval.firstAge }` );
        console.log( `Last age: ${ ageInterval.lastAge }` );
    }
    else
    {
        console.log( 'No age interval' );
    }
}

// -- STATEMENTS

main();
