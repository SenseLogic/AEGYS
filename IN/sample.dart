// -- CONSTANTS

const int minimumPassCount = 0;
const int maximumPassCount = 5;

// -- TYPES

class Being
{
    // -- CONSTRUCTORS

    Being(
        this.name,
        this.age
        );

    // -- ATTRIBUTES

    String 
      name;
    int 
      age;
}

// ~~

class Person
    extends Being
{
    // -- CONSTRUCTORS

    Person(
        super.name,
        super.age,
        this.weight,
        this.dogCount
        );

    // -- ATTRIBUTES

    int 
      weight,
      dogCount;

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
        return "Hello, my name is $name, I'm $age years old and I weight $weight kilograms.";
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
                   + getAgeOffset(
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

// ~~

class AgeInterval
{
    AgeInterval(
        {
            required this.firstAge,
            required this.lastAge
        }
        );

    final int 
      firstAge,
      lastAge;
}

// -- FUNCTIONS

AgeInterval? getAgeInterval(
    List<Person> sortedPersonArray
    )
{
    if ( sortedPersonArray.isEmpty )
    {
        return null;
    }
    else
    {
        return 
            AgeInterval(
                firstAge: sortedPersonArray.first.age,
                lastAge: sortedPersonArray.last.age
                );
    }
}

// ~~

void main(
    )
{
    var passIndex = 0;

    while ( passIndex < maximumPassCount )
    {
        ++passIndex;
    }

    do
    {
        ++passIndex;
    }
    while ( passIndex < 10 );

    final personArray
        = <Person>[
            Person( "Mike", 49, 85, 1 ),
            Person( "Luke", 30, 77, 0 ),
            Person( "John", 30, 72, 3 )
        ];

    personArray.sort(
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
                    return firstPerson.weight - secondPerson.weight;
                }
            }
            catch ( error )
            {
                print( error.toString() );
            }

            return 0;
        }
        );

    final ageInterval = getAgeInterval( personArray );

    if ( ageInterval != null )
    {
        print( "First age: ${ ageInterval.firstAge }" );
        print( "Last age: ${ ageInterval.lastAge }" );
    }
    else
    {
        print( "No age interval" );
    }
}
