#import "Basic";
#import "Print_Color";

guestName: string = "Micah";
guestGender: bool = true;
guestTimeSinceLastMeal: float = 1.23453;

main :: () 
{
    magic: int = 1;
    if magic == 1
    {
        print_color("Name: %", guestName, color=FOREGROUND_GREEN);
    }
    else
    {
        print_color("Name: %", guestName, color=FOREGROUND_RED);
    }
}

DoMatrixPower :: ()
{
    print("name:   %\n", guestName);
    print("gender: %\n", guestGender);
    print("time:   %\n", guestTimeSinceLastMeal);
}



