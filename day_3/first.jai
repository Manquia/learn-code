#import "Basic";
#import "String";
#import "Print_Color";

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

main :: ()
{
    value: int;
    is_valid: bool;
    console_input := get_line();

    value, is_valid, console_input = to_integer(console_input);

    if !is_valid then print("Invalid input!\n");


}