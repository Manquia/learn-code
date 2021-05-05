
// Does this compile?
// What is this?
// What does it do?

#import "Basic";

// value = 8
// 8 % 5 = 3

main :: ()
{
    value: int = 0;

    while value <= 14
    {
        if is_multiple_of(value, 2)    // value is divisible by 5 (true for 0,5,10,15,20,25
        {
            print("foo");
        }
        if is_multiple_of(value, 3)   // value is divisible by 15 (true for 0,15,30
        {
            print("bar");
        }
        value += 1;
    }
}

// guess:  foobarfoobarbarfoofoobarfoobarfoofoobarfoo
// result: foobarfoobarfoofoobarfoobarfoofoobarfoo



is_multiple_of :: (value:int, divisible:int) -> bool
{
    remainder:     int = value % divisible;
    is_divisible: bool = (remainder == 0);
    return is_divisible;
}

// =                     // Means assignment
// NOT THE SAME AS
// ==                    // Comparison
