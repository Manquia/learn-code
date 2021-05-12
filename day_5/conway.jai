#import "Basic";
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
neighbors_alive :: (x: int, y: int) -> int
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

    if left_valid  && g_board[left_index]                      { number_alive += 1; }
    if right_valid && g_board[right_index]                     { number_alive += 1; }
    if up_valid    && g_board[up_index]                        { number_alive += 1; }
    if down_valid  && g_board[down_index]                      { number_alive += 1; }
    if up_valid    && left_valid  && g_board[up_left_index]    { number_alive += 1; }
    if up_valid    && right_valid && g_board[up_right_index]   { number_alive += 1; }
    if down_valid  && left_valid  && g_board[down_left_index]  { number_alive += 1; }
    if down_valid  && right_valid && g_board[down_right_index] { number_alive += 1; }
    
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
            print("[1]");
        }
        else // dead cell
        {
            print("[0]");
        }

        if cell_index % 4 == 3  //@TODO
        {
            print("\n");
        }
    }
}



WIDTH  :int: 4;
HEIGHT :int: 4;

g_board:  [WIDTH * HEIGHT]bool;
g_board2: [WIDTH * HEIGHT]bool;

main :: ()
{
    g_board = bool.[
        false, true , false, false, 
        false, true , false, false, 
        false, true , false, false, 
        false, false, false, false, 
    ];

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
    }

}

execute_simulation :: (current: *[WIDTH * HEIGHT]bool, next: *[WIDTH * HEIGHT]bool)
{
    for cell, cell_index : << current
    {
        x, y :int = index_to_x_y(cell_index);
        alive := neighbors_alive(x, y);

        // Births
        if cell == false
        {
            if alive == 3
            {
                (<< next)[cell_index] = true;
            }
        }

        if cell == true
        {
            // AND && 
            // OR  ||

            if alive == 2 || alive == 3
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