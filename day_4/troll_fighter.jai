#import "Basic";
#load "console_input.jai";

//
// Weapons
// 1) Sword of Destiny
// 2) Fire Bomb
// 3) THE Doge
// 4) Healing potion
//
// Execution Steps 
//
// 1) Print to the user that a troll is attacking them.
// 2) Ask for which weapon the user would like to use
// 3) Use weapon against the troll.
// 4) If the troll dies, We win the game.
// 5) Troll Attacks! We take damage, 
// 6) if the player dies, we lose the game.
// 7) if neither the troll nor the player are dead, GOTO #2
//

// what is damage?                          integer (s64)
// what is health?                          integer (s64)
// How do we know something is dead?        When a character's health is less than or equal to 0
// How do we keep track of health?          integer ---- global/local/member
// How do we select which weapon to use?    console input -> to_integer() ->
//                                          0 = Sword
//                                          1 = Fire Bomb
//                                          2 = THE Doge
//                                          3 = Healing Potion

Weapon :: enum int
{
    Sword         :: 0;
    FireBomb      :: 1;
    THEDoge       :: 2;
    HealingPotion :: 3;
}

use_sword :: ()
{
    troll_hp -= 25;
}
use_fire_bomb :: ()
{
    troll_hp -= 5;
    troll_is_on_fire_for_turn = 3;
}
use_doge :: ()
{
    troll_stuned_for_turn = 1;
}
use_healing_potion :: ()
{
    player_hp += 20;
}

troll_attack :: ()
{
    player_hp -= 25;
}

print_game_state :: ()
{
    print("Player has % hp\n", player_hp);
    print("Troll has % hp\n", troll_hp);

    if troll_is_on_fire_for_turn > 0
    {
        print("Troll is on fire!\n");
    }
}

troll_hp: int = 200;
troll_is_on_fire_for_turn: int = 0; 
troll_stuned_for_turn: int = 0;
player_hp: int = 100;

main :: ()
{
    print_game_state();
    // #1 TODO

    while (troll_hp > 0 && player_hp > 0)
    {
        //#2 TODO 
        print("Choose your weapon by entering 0-3\n");
        print("0 = Sword\n");
        print("1 = Fire Bomb\n");
        print("2 = THE Doge\n");
        print("3 = Healing Potion\n");

        user_input: string = get_line();

        user_input_number:int;
        input_valid: bool;
        user_input_number, input_valid = to_integer(user_input);

        if input_valid == false
        {
            print("input was not valid! try again!\n");
            continue;
        }

        if user_input_number < 0 || user_input_number > 3
        {   
            print("Invalid weapon choice! try again!\n");
            continue;
        }

        player_weapon: Weapon = cast(Weapon)user_input_number;
        print("Chosen weapon: %\n", player_weapon);

        if player_weapon == Weapon.Sword
        {
            use_sword();
        }
        if player_weapon == Weapon.FireBomb
        {
            use_fire_bomb();
        }
        if player_weapon == Weapon.THEDoge
        {
            use_doge();
        }
        if player_weapon == Weapon.HealingPotion
        {
            use_healing_potion();
        }

        // Burn troll if it is in fire!
        if troll_is_on_fire_for_turn > 0
        {
            damage :int = 20;
            print("Troll burns for % damage\n", damage);
            troll_hp -= damage;
            troll_is_on_fire_for_turn -= 1;
        }

        // Troll attacks
        if troll_stuned_for_turn == 0
        {
            troll_attack();
        }
        else
        {
            print("troll does not attack you!\n");
        }
        if troll_stuned_for_turn > 0 // return stun by 1 turn
        {
            troll_stuned_for_turn -= 1;
        }

        print_game_state();
    }


    if player_hp <= 0
    {
        print("You have died!\n");
    }

    if troll_hp <= 0
    {
        print("The troll had died!\n");
    }    
}