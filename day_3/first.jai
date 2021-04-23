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



prompt_for_integer :: (message: string) -> int
{
    // Prompt for seed number
    while true
    {
        print(message);
        console_input :string = get_line();

        // was input valid?
        value: int;
        is_valid: bool;
        value, is_valid = to_integer(console_input);

        if is_valid
        {
            return value; // Success, Got a value from the function
        }
        else
        {
            print("Invalid input, Try again.\n");
        }
    }
}


main :: ()
{
    accumulator: int = 0;
    // Prompt for seed number
    while true
    {
        print("Please Input a value: ");
        console_input :string = get_line();

        if console_input.count == 0
        {
            break;
        }

        // was input valid?
        value: int;
        was_integer_readable: bool;
        value, was_integer_readable = to_integer(console_input);

        if was_integer_readable
        {
            accumulator = accumulator + value;
            print("%1", accumulator);
        }

        if !was_integer_readable
        {
            print("Invalid input, Try again.\n");
        }
    }
}





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