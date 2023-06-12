module default {
    type Restaurant {
        required name: str;
        required address: str;
        required phone: str;
        required multi seatings: Seating;
    }

    type Seating {
        required type: str {
            constraint one_of('standard', 'outdoor', 'bar')
        }
         required chairs: int16 {
            constraint max_value(12)
        };
        required freeChairs: int16 {
            constraint max_value(12)
        };
    }

    type Reservation {
        required client: Person;
        required restaurant: Restaurant;
        required date: str;
        required time: str;
        required seatings: Seating;
    }

    type Person {
        required name: str;
        required surname: str;
        required phone: str;
        required age: int16;
        email: str {
            constraint regexp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
        }
        link reservations := .<client[is Reservation];
    }
}
