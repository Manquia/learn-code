#import "Basic";
#import "Print_Color";
#import "Random";
/*
This is a solitary game, or one with just one player, and the
play of a typical game goes like this:

Player chooses an initial set up.
Rules are applied to see what happens in the next generation.

Play continues until one of three things happens:
all cells are dead, no cells change from one generation to the next,
or the pattern flips back and forth between two or more positions.

Births: Each dead cell adjacent to exactly three live neighbors
        will become live in the next generation.

Death by isolation: Each live cell with one or fewer live neighbors
                    will die in the next generation.

Death by overcrowding: Each live cell with four or more live neighbors
                    will die in the next generation.

Survival: Each live cell with either two or three live neighbors will
          remain alive for the next generation.

   Gen 0        Gen 1        Gen 2        Gen 3        Gen 4        Gen 5    
                                                                             
[0][1][0][0] [0][0][0][0] [0][1][0][0] [0][0][0][0] [0][1][0][0] [0][0][0][0]
[0][1][0][0] [1][1][1][0] [0][1][0][0] [1][1][1][0] [0][1][0][0] [1][1][1][0]
[0][1][0][0] [0][0][0][0] [0][1][0][0] [0][0][0][0] [0][1][0][0] [0][0][0][0]
[0][0][0][0] [0][0][0][0] [0][0][0][0] [0][0][0][0] [0][0][0][0] [0][0][0][0]
*/

x_y_to_index :: (x: int, y: int) -> index:int
{
    index: int = x + (y * WIDTH);
    return index;
}

index_to_x_y :: (index: int) -> x: int, y: int
{
    x: int = index % WIDTH;   
    y: int = index / WIDTH;

    return x, y;
}

// How do we represent live?    as a bool when true
// How do we represent dead?    as a bool when false
// How do we apply the rules?              
// How do we move between gerneration?     pointer swap, global variable assignments
// How do we start the simulation?         Micah will give you a thing
// How do we represent the whole simulation of a single generation?  array/string


/*
Address
 \    WIDTH                     |                    INDEX
y \_x 0  1  2  3                | 0  1  2  3   4  5  6  7   8  9  10 11  12 13 14 15
   0 [1][0][0][0] ------------>  [1][0][0][0]_[0][1][0][0]_[0][0][1][0]_[0][0][0][1]
   1 [0][1][0][0] ----------------------------/            /            /
   2 [0][0][1][0] ----------------------------------------/            /
   3 [0][0][0][1] ----------------------------------------------------/

[1][0][0][0]
[0][1][0][0]
[0][0][1][0]
[0][0][0][1]

*/
neighbors_alive :: (board: *[WIDTH * HEIGHT]bool, x: int, y: int) -> int
{
    index: int = x_y_to_index(x, y);

    left_index:  int = index - 1;
    left_valid: bool = (index % WIDTH > 0);
    right_index: int = index + 1;
    right_valid: bool = (index % WIDTH < WIDTH - 1);

    up_index:   int = index - WIDTH;
    up_valid:  bool = index >= WIDTH;
    down_index: int = index + WIDTH;
    down_valid:bool = index < (HEIGHT - 1) * WIDTH;

    up_left_index:  int = index - WIDTH - 1;
    up_right_index: int = index - WIDTH + 1;

    down_left_index:  int = index + WIDTH - 1;
    down_right_index: int = index + WIDTH + 1;
    
    number_alive: int = 0;

    if left_valid  && (<< board)[left_index]                      { number_alive += 1; }
    if right_valid && (<< board)[right_index]                     { number_alive += 1; }
    if up_valid    && (<< board)[up_index]                        { number_alive += 1; }
    if down_valid  && (<< board)[down_index]                      { number_alive += 1; }
    if up_valid    && left_valid  && (<< board)[up_left_index]    { number_alive += 1; }
    if up_valid    && right_valid && (<< board)[up_right_index]   { number_alive += 1; }
    if down_valid  && left_valid  && (<< board)[down_left_index]  { number_alive += 1; }
    if down_valid  && right_valid && (<< board)[down_right_index] { number_alive += 1; }
    
    return number_alive;
}

print_board :: (board: []bool, generation: int)
{
    print("conway generation: %\n", generation);

    for cell, cell_index :board
    {
        // print cell
        if cell
        {
            print_color("[1]", color = FOREGROUND_BLUE);
        }
        else // dead cell
        {
            print_color("[0]", color = FOREGROUND_RED);
        }

        if cell_index % WIDTH == (WIDTH - 1)
        {
            print("\n");
        }
    }
}



WIDTH  :int: 50;
HEIGHT :int: 50;

g_board:  [WIDTH * HEIGHT]bool;
g_board2: [WIDTH * HEIGHT]bool;

main :: ()
{
    // glider
    if false
    {
        g_board[x_y_to_index(3,3)] = true;

        g_board[x_y_to_index(4,4)] = true;
        g_board[x_y_to_index(5,4)] = true;

        g_board[x_y_to_index(3,5)] = true;
        g_board[x_y_to_index(4,5)] = true;
        
        //  X__
        //  _XX
        //  XX_
    }

    // Initialize to random noise!
    for * cell, cell_index :g_board
    {
        alive :bool = random_get_zero_to_one() >= 0.5;
        << cell = alive;
    }
    
    print_board(g_board, 0);

    pointer_to_current: *[WIDTH * HEIGHT]bool = *g_board;
    pointer_to_next:    *[WIDTH * HEIGHT]bool = *g_board2;

    generation_counter: int = 1;
    while true
    {
        execute_simulation(pointer_to_current, pointer_to_next);

        print_board(<< pointer_to_next, generation_counter);
        generation_counter += 1;

        // swap pointers!
        temp: *[WIDTH * HEIGHT]bool = pointer_to_next;
        pointer_to_next = pointer_to_current;
        pointer_to_current = temp;

        sleep_milliseconds(350);
    }

}

execute_simulation :: (current: *[WIDTH * HEIGHT]bool, next: *[WIDTH * HEIGHT]bool)
{
    for cell, cell_index : << current
    {
        x, y :int = index_to_x_y(cell_index);
        alive := neighbors_alive(current, x, y);
        
        // erase old state of previous generation by making them all dead.
        (<< next)[cell_index] = false;

        // Births
        if cell == false
        {
            if alive == 3
            {
                (<< next)[cell_index] = true;
            }
        }

        // Death by isolation
        if cell == true
        {
            if alive <= 1
            {
                (<< next)[cell_index] = false;
            }
        }
        
        // Death by overcrowding
        if cell == true
        {
            if alive >= 4
            {
                (<< next)[cell_index] = false;
            }
        }

        // Survival
        if cell == true
        {
            if (alive == 2) || (alive == 3)
            {
                (<< next)[cell_index] = true;
            }
        }
    }
}

// Impliment remaining 3 rules!
/*
Births: Each dead cell adjacent to exactly three live neighbors
        will become live in the next generation.

Death by isolation: Each live cell with one or fewer live neighbors
                    will die in the next generation.

Death by overcrowding: Each live cell with four or more live neighbors
                    will die in the next generation.

Survival: Each live cell with either two or three live neighbors will
          remain alive for the next generation.
*/