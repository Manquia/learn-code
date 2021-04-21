
// Basic outline
/*
Review:

functions: inputs, outputs, multiple return values
intrinsic types
user-defined types
if/else

*/
is_color_red :: (r: u8, g: u8, b: u8) -> bool
{
    if r > g + b 
    {
        return true;
    }

    return false;
}


min :: (v0: int, v1: int) -> result: int
{
    if v0 < v1
    {
        return v0;
    }
    else
    {
        return v1;
    }
}



/*
New subjects:

while condtion {}
for 0..n {}

extra subjects:

size_of()
*/

#import "Basic"; // print
main :: ()
{
    counter: int = 10;
    while counter <= 2
    {
        print("I am doing a thing (WHILE)\n");
        counter = counter + 1;
    }
    
    for 1..5
    {
        print("I am doing a thing (FOR ..)\n");
    }
}
