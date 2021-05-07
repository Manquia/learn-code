
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


// How do we represent live?    as a bool when true
// How do we represent dead?    as a bool when false
// How do we apply the rules?              
// How do we move between gerneration?     pointer swap, global variable assignments
// How do we start the simulation?         Micah will give you a thing
// How do we represent the whole simulation of a single generation?  array/string

neighbors_alive :: (x: int, y: int) -> int
{
    // @TODO @Homework Write this function
    return -1; // placeholder
}


WIDTH  :: 4;
HEIGHT :: 4;

g_board : [WIDTH * HEIGHT]bool;

main :: ()
{
    g_board = .[
        false, true , false, false, 
        false, true , false, false, 
        false, true , false, false, 
        false, false, false, false, 
    ];

    // Reference Notes
    x: int = 1;
    y: int = 1;
    at_index: int = x + (y * WIDTH);

    left_of_at  :int = at_index - 1;
    right_of_at :int = at_index + 1;

    up_of_at   :int = at_index - WIDTH;
    down_of_at :int = at_index + WIDTH;

    top_left_of_at  :int   = at_index - WIDTH - 1;
    top_right_of_at :int   = at_index - WIDTH + 1;
    
    bot_left_of_at  :int   = at_index + WIDTH - 1;
    bot_right_of_at :int   = at_index + WIDTH + 1;
    // END Reference Notes
}
