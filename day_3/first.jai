#import "Basic";
#import "String";
#import "Print_Color";
#import "Random";

#load "console_input.jai";

// Practice:
// 1) Number guessing game
//   - Prompt for seed number
//   - Prompt to guess the secret number<---\
//   - Output if guess is correct           |
//   - If guess correct, goto WIN, else  ---/
// 2) Recept accumulator (Add all inputs together for end result)
//   - Prompt for recept amount             <---\
//   - Output total cost accumulated            | if N
//   - if enter empty prompt ask if done (Y/N)?-/
// 3) Budget buyer (price + quanity prompt. Let you know how much money you have left after each purchase)
//   - Prompt for budget
//   - Prompt for purchase cost (ea)                 <---\
//   - Prompt for quantity of purchase                   | repeat steps if money left
//   - Output if there is enough money and how much left-/

my_min :: (v0: int, v1: int) -> return_value: int
{
    if v0 < v1
    {
        return v0;
    }
    return v1;
}

my_max :: (v0: int, v1: int) -> return_value: int
{
    if v0 > v1
    {
        return v0;
    }
    return v1;
}

// my_clamp is a function with 3 input integers.
// The input variable names are "value" "min", "max".
// and return 1 integer.
// 
// my_clamp(30,   3, 20)  // returns 20
// my_clamp(-4,   5, 10)  // returns 5
// my_clamp(26, -15, 44)  // returns 26
//

my_clamp :: (v: int, min: int, max: int) -> int
{
    if v < min
    {
        return min;
    }
    if v > max
    {
        return max;
    }
    return v;
}


mario_world_simulate :: ()
{


  print("It’s a me-aaa. Mario!\n");
}


foobar :: ()
{

  print("DND for life!\n");
}


main :: ()
{
    is_ham :bool = (10 - 10) > -1;

    if is_ham
    {
        print("Yes Ham!");
    }
    else
    {
        print("No Ham");
    }
}

// #3
/*
main :: ()
{
    num0:int = 1;
    num1:int = 2;
    num2:int = 3; 
    num3:int = 4;
    num4:int = 5;
    num5:int = 6;

    min_res0:int = my_min(num0, num1);
    min_res1:int = my_min(num1, num2);
    min_res2:int = my_min(num2, num3);
    min_res3:int = my_min(num3, num4);
    min_res4:int = my_min(num4, num5);
    
    max_res0:int = my_max(num0, num1);
    max_res1:int = my_max(num1, num2);
    max_res2:int = my_max(num2, num3);
    max_res3:int = my_max(num3, num4);
    max_res4:int = my_max(num4, num5);


    print("%\n", min_res0);
    print("%\n", min_res1);
    print("%\n", min_res2);
    print("%\n", min_res3);
    print("%\n", min_res4);
    
    print("%\n", max_res0);
    print("%\n", max_res1);
    print("%\n", max_res2);
    print("%\n", max_res3);
    print("%\n", max_res4);




}
*/

// #2
/*
main :: ()
{
    accumulator: float = 0;
    // Prompt for seed number
    while true
    {
        print("Please Input a value: ");
        console_input :string = get_line();
        print("\n");

        if console_input.count == 0
        {
            break;
        }

        // was input valid?
        value: float;
        was_integer_readable: bool;
        value, was_integer_readable = string_to_float(console_input);

        if was_integer_readable
        {
            accumulator = accumulator + value;
            print("%1\n", accumulator);
        }

        if !was_integer_readable
        {
            print("Invalid input, Try again.\n");
        }
    }
}
*/

// #1
/*
main :: ()
{
    seed_value: int;
    is_valid: bool;

    // Prompt for seed number
    print("Please enter the seed number:");
    console_input :string = get_line();
    print("\n");

    // was input valid?
    seed_value, is_valid = to_integer(console_input);
    if !is_valid then print("Provided seed value was not valid.\n");

    random_seed(xx seed_value);
    secret_number :u32 = random_get() % 100; // 0 - 99

    while true
    {
        print("GIVE ME YOUR BEST SHOT! WHAT IS THE ANSWER!!!\n");
        console_input = get_line();

        // was input valid?
        guess_value: int;
        guess_value, is_valid = to_integer(console_input);
        if !is_valid then print("Your guess was crude!\n");

        // Correct?
        if guess_value == secret_number
        {
            print("Congradulations, you're a winner\n");
            break;
        }

        // Incorrect guess. Barate the user!
        if guess_value != secret_number
        {
            print("You're bad at this game!\n");
            if guess_value > secret_number
            {
                print("Too high\n");
            }
            if guess_value < secret_number
            {
                print("Too Low\n");
            }
        }
    }
}
*/