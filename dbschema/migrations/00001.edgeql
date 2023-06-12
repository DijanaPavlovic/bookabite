CREATE MIGRATION m17y4vktlrali2birujbzrsy5uacc3htkqgb4dkcdaiqgkbdp4g65a
    ONTO initial
{
  CREATE FUTURE nonrecursive_access_policies;
  CREATE TYPE default::Person {
      CREATE REQUIRED PROPERTY age: std::int16;
      CREATE PROPERTY email: std::str {
          CREATE CONSTRAINT std::regexp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      };
      CREATE REQUIRED PROPERTY name: std::str;
      CREATE REQUIRED PROPERTY phone: std::str;
      CREATE REQUIRED PROPERTY surname: std::str;
  };
  CREATE TYPE default::Seating {
      CREATE REQUIRED PROPERTY chairs: std::int16 {
          CREATE CONSTRAINT std::max_value(12);
      };
      CREATE REQUIRED PROPERTY freeChairs: std::int16 {
          CREATE CONSTRAINT std::max_value(12);
      };
      CREATE REQUIRED PROPERTY type: std::str {
          CREATE CONSTRAINT std::one_of('standard', 'outdoor', 'bar');
      };
  };
  CREATE TYPE default::Restaurant {
      CREATE REQUIRED MULTI LINK seatings: default::Seating;
      CREATE REQUIRED PROPERTY address: std::str;
      CREATE REQUIRED PROPERTY name: std::str;
      CREATE REQUIRED PROPERTY phone: std::str;
  };
  CREATE TYPE default::Reservation {
      CREATE REQUIRED LINK client: default::Person;
      CREATE REQUIRED LINK restaurant: default::Restaurant;
      CREATE REQUIRED LINK seatings: default::Seating;
      CREATE REQUIRED PROPERTY date: std::str;
      CREATE REQUIRED PROPERTY time: std::str;
  };
  ALTER TYPE default::Person {
      CREATE LINK reservations := (.<client[IS default::Reservation]);
  };
};
