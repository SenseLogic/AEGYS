<?php
// -- CONSTANTS

const
    MINIMUM_PASS_COUNT = 0,
    MAXIMUM_PASS_COUNT = 5;

// -- TYPES

class AgeInterval
{
    // -- ATTRIBUTES

    public int
        firstAge,
        lastAge;

    // -- CONSTRUCTORS

    public function __construct(
        int $firstAge,
        int $lastAge
        )
    {
        $this->firstAge = $firstAge;
        $this->lastAge = $lastAge;
    }
}

// ~~

class Being
{
    // -- ATTRIBUTES

    public string
        $name;
    public int
        $age;

    // -- CONSTRUCTORS

    public function __construct(
        string $name,
        int $age
        )
    {
        $this->name = $name;
        $this->age = $age;
    }
}

// ~~

class Person extends Being
{
    // -- ATTRIBUTES

    public float
        $weight,
        $dogCount;

    // -- CONSTRUCTORS

    public function __construct(
        string $name,
        int $age,
        float $weight,
        float $dogCount
        )
    {
        parent::__construct( $name, $age );
        $this->weight = $weight;
        $this->dogCount = $dogCount;
    }

    // -- INQUIRIES

    public function getAge(
        ): int
    {
        return $this->age;
    }

    // ~~

    public function getAgeOffset(
        int $otherAge
        ): int
    {
        return $otherAge - $this->age;
    }

    // ~~

    public function getHelloMessage(
        ): string
    {
        return "Hello, my name is {$this->name}, I'm {$this->age} years old and I weight {$this->weight} kilograms.";
    }

    // -- OPERATIONS

    public function setAge(
        int $age
        ): void
    {
        $this->age = $age;
    }

    // ~~

    public function setFakeAge(
        int $age
        ): void
    {
        if ( $age > 0
             && $age < 50
             && ( $age < 20
                  || $age > 40 ) )
        {
            $this->age
                += ( $age
                     + ( $age - 2 )
                     + ( $age
                         * ( $age + 10 )
                         * ( $age + 20 ) ) )
                   + $this->getAgeOffset(
                        $age * 2
                        - 20
                        );
        }
        elseif ( $age > 20
                 && $age < 40
                 && ( $age < 25
                      || $age > 35 ) )
        {
            $this->age
                = (int)round(
                    $age * 0.5
                    );
        }
        else
        {
            $this->age = $age + 10;
        }
    }
}

// -- FUNCTIONS

function getAgeInterval(
    array $sortedPersonArray
    ): ?AgeInterval
{
    if ( count( $sortedPersonArray ) === 0 )
    {
        return null;
    }
    else
    {
        return
            new AgeInterval(
                $sortedPersonArray[ 0 ]->age,
                $sortedPersonArray[ count( $sortedPersonArray ) - 1 ]->age
                );
    }
}

// ~~

function main(
    ): void
{
    $passIndex = 0;

    while ( $passIndex < 5 )
    {
        $passIndex += 1;
    }

    while ( true )
    {
        $passIndex += 1;

        if ( $passIndex >= 10 )
        {
            break;
        }
    }

    $personArray
        = [
              new Person( 'Mike', 49, 85.0, 1.0 ),
              new Person( 'Luke', 30, 77.0, 0.0 ),
              new Person( 'John', 30, 72.0, 3.0 )
          ];

    usort(
        $personArray,
        function (
            Person $firstPerson,
            Person $secondPerson
            ): int
        {
            try
            {
                if ( $firstPerson->age !== $secondPerson->age )
                {
                    return $firstPerson->age <=> $secondPerson->age;
                }
                else
                {
                    return $firstPerson->weight <=> $secondPerson->weight;
                }
            }
            catch ( Throwable $error )
            {
                print( $error->getMessage() . PHP_EOL );
            }

            return 0;
        }
        );

    $ageInterval = getAgeInterval( $personArray );

    if ( $ageInterval !== null )
    {
        print( "First age: {$ageInterval->firstAge}" . PHP_EOL );
        print( "Last age: {$ageInterval->lastAge}" . PHP_EOL );
    }
    else
    {
        print( 'No age interval' . PHP_EOL );
    }
}

// -- STATEMENTS

main();
