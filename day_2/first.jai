#import "Basic";
#import "Print_Color";


SECOND :: 1;
MINUTE :: SECOND * 60;
HOUR   :: MINUTE * 60;

// returns the current time in seconds from
// the start of the day.
get_current_time :: () -> int
{
    return make_time(9, 30);
}

get_hour :: (time: int) -> int
{
    return (time / HOUR) % 24;
}

get_minute :: (time: int) -> int
{
    return (time / MINUTE) % 60;
}

make_time :: (hr: int = 0, min: int = 0, sec: int = 0) -> int #expand
{
    return hr * HOUR + min * MINUTE + sec * SECOND;
}

GuestInfo :: struct
{
    name: string;

    check_in_time: int;
    check_out_time: int;
}

can_guest_check_in :: (info: GuestInfo) -> bool
{
    // @TODO

    return false;
}
print_guest_status :: (info: GuestInfo)
{
    if can_guest_check_in(info)
    {
        print_color("Guest % can now check in\n", info.name, color=FOREGROUND_GREEN);
    }
    else
    {
        print_color("Checkin period: (%2:%3 - %4:%5) Guest %1 cannot checkin.\n",
            info.name,
            get_hour(info.check_in_time), get_minute(info.check_in_time),
            get_hour(info.check_out_time), get_minute(info.check_out_time),
            color=FOREGROUND_RED);
    }
}

main :: () 
{
    g1,g2,g3,g4,g5: GuestInfo;
    g1.name = "Bobby";
    g1.check_in_time  = make_time(6,  25);
    g1.check_out_time = make_time(18, 25);
    
    g2.name = "Richard";
    g2.check_in_time  = make_time(11, 20);
    g2.check_out_time = make_time(20, 20);
    
    g3.name = "Trever";
    g3.check_in_time  = make_time(9,  15);
    g3.check_out_time = make_time(15, 30);
    
    g4.name = "Aleksei";
    g4.check_in_time  = make_time(10, 45);
    g4.check_out_time = make_time(17, 30);
    
    g5.name = "Levi";
    g5.check_in_time  = make_time(14, 15);
    g5.check_out_time = make_time(23, 30);

    print_guest_status(g1);
    print_guest_status(g2);
    print_guest_status(g3);
    print_guest_status(g4);
    print_guest_status(g5);
}




