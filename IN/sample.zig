// -- IMPORTS

const std = @import( "std" );

// -- CONSTANTS

const
    minimumPassCount: i32 = 0,
    maximumPassCount: i32 = 5;

// -- TYPES

const Being = 
    struct
    {
        // -- PROPERTIES

        name: []const u8,
        age: i32,

        // -- CONSTRUCTORS

        pub fn init(
            name: []const u8,
            age: i32
            )
            Being
        {
            return 
                .{
                    .name = name,
                    .age = age,
                };
        }
    };

// ~~

const Person = 
    struct
    {
        // -- PROPERTIES

        being: Being,
        weight: i32,
        dogCount: i32,

        // -- CONSTRUCTORS

        pub fn init(
            name: []const u8,
            age: i32,
            weight: i32,
            dogCount: i32
            )
            Person
        {
            return 
                .{
                    .being = Being.init( name, age ),
                    .weight = weight,
                    .dogCount = dogCount,
                };
        }

        // -- INQUIRIES

        pub fn getAge(
            self: *const Person
            )
            i32
        {
            return self.being.age;
        }

        // ~~

        pub fn getAgeOffset(
            self: *const Person,
            otherAge: i32
            )
            i32
        {
            return otherAge - self.being.age;
        }

        // ~~

        pub fn getHelloMessage(
            self: *const Person,
            allocator: std.mem.Allocator
            )
            ![]u8
        {
            return std.fmt.allocPrint(
                allocator,
                "Hello, my name is {s}, I'm {d} years old and I weight {d} kilograms.",
                .{
                    self.being.name,
                    self.being.age,
                    self.weight,
                }
                );
        }

        // -- OPERATIONS

        pub fn setAge(
            self: *Person,
            age: i32
            )
            void
        {
            self.being.age = age;
        }

        // ~~

        pub fn setFakeAge(
            self: *Person,
            age: i32
            )
            void
        {
            if ( age > 0
                 and age < 50
                 and ( age < 20
                       or age > 40 ) )
            {
                self.being.age
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
                      and age < 40
                      and ( age < 25
                            or age > 35 ) )
            {
                self.being.age = @intFromFloat( @round( @as( f64, @floatFromInt( age ) ) * 0.5 ) );
            }
            else
            {
                self.being.age = age + 10;
            }
        }
    };

// ~~

const AgeInterval = 
    struct
    {
        firstAge: i32,
        lastAge: i32,
    };

// -- FUNCTIONS

fn getAgeInterval(
    sortedPersonArray: []const Person
    ) ?AgeInterval
{
    if ( sortedPersonArray.len == 0 )
    {
        return null;
    }
    else
    {
        return 
            AgeInterval
            {
                .firstAge = sortedPersonArray[ 0 ].being.age,
                .lastAge = sortedPersonArray[ sortedPersonArray.len - 1 ].being.age,
            };
    }
}

// ~~ 

fn getPersonComparison(
    _: void,
    firstPerson: Person,
    secondPerson: Person
    ) bool
{
    if ( firstPerson.being.age != secondPerson.being.age )
    {
        return firstPerson.being.age < secondPerson.being.age;
    }
    else
    {
        return firstPerson.weight < secondPerson.weight;
    }
}

// ~~

fn run(
    ) !void
{
    var passIndex: i32 = 0;

    while ( passIndex < 5 )
    {
        passIndex += 1;
    }

    while ( true )
    {
        passIndex += 1;

        if ( passIndex < 10 )
        {
            continue;
        }
        else
        {
            break;
        }
    }

    var personArray = 
        [_]Person
        {
            Person.init( "Mike", 49, 85, 1 ),
            Person.init( "Luke", 30, 77, 0 ),
            Person.init( "John", 30, 72, 3 ),
        };

    std.sort.pdq(
        Person,
        &personArray,
        {},
        getPersonComparison
        );

    const ageInterval = getAgeInterval( personArray[ 0.. ] );

    if ( ageInterval != null )
    {
        std.debug.print( "First age: {d}\n", .{ ageInterval.?.firstAge } );
        std.debug.print( "Last age: {d}\n", .{ ageInterval.?.lastAge } );
    }
    else
    {
        std.debug.print( "No age interval\n", .{} );
    }

    _ = minimumPassCount;
    _ = maximumPassCount;
}

// -- STATEMENTS

pub fn main(
    ) !void
{
    try run();
}
