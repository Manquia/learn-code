Jai Skill Check #0

Fill in the answer to the following questions

//1) How many bits makes up a byte? 8
magic:int = 9001;
crazy:float = 8008.0;
print("Today I rode %2 and ate %1 candy.\n", crazy, magic);

//2) What does this print to the console? = 
Today I rode 9001 and ate 8008.0 candy.

my_c:u8 = #char "a";
//3) What is the value of ‘my_c’?  == 97


is_ham:bool = (10 - 10) > -1;
if is_ham
{
    print("Yes Ham!");
}
else
{
    print("No Ham");
}

//4) What does the above print?
Yes ham!
//5) How many bytes long is the unsigned integer type u32? 
32 bits
//6) Write the declaration of a variable with the name “foozle” and give it the type “int”. 
foozle: int;

//7) Write the declaration of a variable with the name “spiderman” and give it the type
//   "Character" and initialize it with the value 1337.
spiderman: Character = 1337;

//8) Write a function called “main” (program entry point) that takes no input parameters
//   and returns nothing. 
main :: ()
{
}

//9) Write a function called “CryForHelp” that takes 1 input parameter called “location”
//   of type “Vector2” and returns 2 output parameters with the types “float” and “bool”.
CryForHelp :: (location: Vector2) -> (output1: float, output2: bool)
{
}

//10) Write a function called “Destroy” that takes 3 input parameters called “object” of
//    type “Object”, “delayed_death” of type “float”, and “death_effect” of type “VisualEffect”.
Destroy :: (object: Object, delayed_death: float, death_effect: VisualEffect)
{
}

//11) Write the command to import the “String” module.
#import "String";

//12) Write the command to load a jai file called “MySpecialMath.jai”
#load "MySpecialMath.jai";

// ============================================================================
//13) Write a local variable inside the “foobar” function with the name “bar” and type “s32”.
foobar :: ()
{
    bar: s32;
    print("DND for life!\n");
}

// ============================================================================
//14) Write a global variable called “player_count” with any signed integer type.
player_count: int;

mario_world_simulate :: ()
{
  print("It’s a me-aaa. Mario!\n");
}

// ============================================================================
//15) Write two local variables inside the main function with any name, but they
//    must be of type string and assigned an initial string literal.
main :: ()
{
    flying_pig_color : string = "Pink";
    flying_Pig_name : string = "George";
}
