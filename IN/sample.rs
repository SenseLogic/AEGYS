// -- IMPORTS

use std::collections::HashMap;

// -- CONSTANTS

const MINIMUM_PASS_COUNT: i32 = 0;
const MAXIMUM_PASS_COUNT: i32 = 5;

// -- TYPES

pub struct Being
{
    // -- ATTRIBUTES

    pub name: String,
    pub age: i32,
}

// ~~

impl Being
{
    // -- CONSTRUCTORS

    pub fn new(
        name: String,
        age: i32
        ) -> Self
    {
        Self
        {
            name,
            age,
        }
    }
}

// ~~

pub struct Person
{
    // -- ATTRIBUTES

    pub being: Being,
    pub weight: f64,
    pub dog_count: f64,
}

// ~~

impl Person
{
    // -- CONSTRUCTORS

    pub fn new(
        name: String,
        age: i32,
        weight: f64,
        dog_count: f64
        ) -> Self
    {
        Self
        {
            being: Being::new( name, age ),
            weight,
            dog_count,
        }
    }

    // -- INQUIRIES

    pub fn get_age(
        &self
        ) -> i32
    {
        return self.being.age;
    }

    // ~~

    pub fn get_age_offset(
        &self,
        other_age: i32
        ) -> i32
    {
        return other_age - self.being.age;
    }

    // ~~

    pub fn get_hello_message(
        &self
        ) -> String
    {
        return format!(
            "Hello, my name is {}, I'm {} years old and I weight {} kilograms.",
            self.being.name,
            self.being.age,
            self.weight
            );
    }

    // -- OPERATIONS

    pub fn set_age(
        &mut self,
        age: i32
        )
    {
        self.being.age = age;
    }

    // ~~

    pub fn set_fake_age(
        &mut self,
        age: i32
        )
    {
        if age > 0
           && age < 50
           && ( age < 20
                || age > 40 )
        {
            self.being.age
                += ( age
                     + ( age - 2 )
                     + ( age
                         * ( age + 10 )
                         * ( age + 20 ) ) )
                   + self.get_age_offset(
                         age * 2
                         - 20
                         );
        }
        else if age > 20
                && age < 40
                && ( age < 25
                     || age > 35 )
        {
            self.being.age = ( ( age as f64 ) * 0.5 ).round() as i32;
        }
        else
        {
            self.being.age = age + 10;
        }
    }
}

// -- FUNCTIONS

pub fn get_age_interval(
    sorted_person_vector: &Vec<Person>
    ) -> Option<HashMap<String, i32>>
{
    if sorted_person_vector.is_empty()
    {
        return None;
    }
    else
    {
        let mut age_interval: HashMap<String, i32>
            = HashMap::new();

        age_interval.insert(
            String::from( "firstAge" ),
            sorted_person_vector[ 0 ].being.age
            );

        age_interval.insert(
            String::from( "lastAge" ),
            sorted_person_vector[ sorted_person_vector.len() - 1 ].being.age
            );

        return Some( age_interval );
    }
}

// ~~

fn main(
    )
{
    let mut pass_index = 0;

    while pass_index < 5
    {
        pass_index += 1;
    }

    loop
    {
        pass_index += 1;

        if pass_index >= 10
        {
            break;
        }
    }

    let mut person_vector: Vec<Person>
        = vec![
            Person::new( String::from( "Mike" ), 49, 85.0, 1.0 ),
            Person::new( String::from( "Luke" ), 30, 77.0, 0.0 ),
            Person::new( String::from( "John" ), 30, 72.0, 3.0 ),
        ];

    person_vector.sort_by(
        | first_person, second_person |
        {
            if first_person.being.age != second_person.being.age
            {
                return first_person.being.age.cmp( &second_person.being.age );
            }
            else
            {
                return
                    first_person
                        .weight
                        .partial_cmp( &second_person.weight )
                        .unwrap();
            }
        }
        );

    let age_interval = get_age_interval( &person_vector );

    if age_interval.is_some()
    {
        let age_interval_value = age_interval.unwrap();

        println!(
            "First age: {}",
            age_interval_value.get( "firstAge" ).unwrap()
            );

        println!(
            "Last age: {}",
            age_interval_value.get( "lastAge" ).unwrap()
            );
    }
    else
    {
        println!( "No age interval" );
    }
}
