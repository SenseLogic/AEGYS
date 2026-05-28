// -- CONSTANTS

const
    minimumPassCount: number = 0,
    maximumPassCount: number = 5;

// -- TYPES

interface AgeInterval
{
    firstAge: number;
    lastAge: number;
}

// ~~

class Being
{
    // -- ATTRIBUTES

    name: string;
    age: number;

    // -- CONSTRUCTORS

    constructor(
        name: string,
        age: number
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
    // -- ATTRIBUTES

    weight: number;
    dogCount: number;

    // -- CONSTRUCTORS

    constructor(
        name: string,
        age: number,
        weight: number,
        dogCount: number
        )
    {
        super( name, age );
        this.weight = weight;
        this.dogCount = dogCount;
    }

    // -- INQUIRIES

    getAge(
        ): number
    {
        return this.age;
    }

    // ~~

    getAgeOffset(
        otherAge: number
        ): number
    {
        return otherAge - this.age;
    }

    // ~~

    getHelloMessage(
        ): string
    {
        return `Hello, my name is ${ this.name }, I'm ${ this.age } years old and I weight ${ this.weight } kilograms.`;
    }

    // -- OPERATIONS

    setAge(
        age: number
        ): void
    {
        this.age = age;
    }

    // ~~

    setFakeAge(
        age: number
        ): void
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
    sortedPersonArray: Person[]
    ): AgeInterval | null
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
    ): void
{
    let passIndex: number = 0;

    while ( passIndex < 5 )
    {
        ++passIndex;
    }

    do
    {
        ++passIndex;
    }
    while ( passIndex < 10 );

    let personArray: Person[]
        = [
            new Person( 'Mike', 49, 85, 1 ),
            new Person( 'Luke', 30, 77, 0 ),
            new Person( 'John', 30, 72, 3 )
        ];

    personArray.sort(
        ( firstPerson: Person, secondPerson: Person ): number =>
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

    let ageInterval: AgeInterval | null = getAgeInterval( personArray );

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
