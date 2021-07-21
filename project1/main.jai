#import "Basic";


#import "raylib-jai";
#load "raylib/raymath.jai";
Math :: #import "Math";

#load "background.jai";
#load "player.jai";
#load "bullet.jai";
#load "enemy_turret.jai";
#load "utils.jai";
#load "game.jai";
#load "sandbox.jai";


// Project 1: Space Saga
// 
// Control a powerful ship in this top-down 2D shooter manuvering through enemy attacks
// while delivering devistating blows to the enemy fleet. Become wanted and the empire
// will send elite battleships to destoy you. Scavenge enemy wreckage to empower your arsence
// in this epic space saga.
//

// elements:
//   player ship
//     controller/input (DONE), hp (DONE), lives(skip), art/sprite/texture(DONE), size (DONE), dodge/barrel roll? (@MAYBE) 
//     weapons
//       Primary Fire (DONE)
//         Rate/cooldown, damage (DONE), size (DONE), speed (DONE)
//       Secondary Fire (@Maybe)
//         Rate/cooldown (DONE), damage(DONE), size(DONE), speed(DONE)
//     movement
//       speed(DONE) 
//   enemy ships (1)
//     ai/behavior, art/texture(DONE), hp(DONE), weapons (DONE)
//   elite ship (1) (skip)
//     ai/behavior, art/texture, hp, weapons
//   background (done)
//     art/texture (done)
//   
//

//
// dodge/barrel roll? (@MAYBE) 
// Secondary Fire (@Maybe)
//
// Win condition, What does this look like?
//  Objective: Kill 100 enemies
//  Rule: If there are less than 5 enemies, spawn an enemy in a random location near the top of the screen.
//
// Loose Condition, what does this look like?
//  Rule: If player hp goes below 1, then play explosion.
//  

//
// Start Screen (Game State)
// Loose Screen (Game State)
// Win Screen (Game State)
// Gameplay (Current game)
//

main :: ()
{
    InitWindow(800, 600, "Space Invaders");
    defer CloseWindow();

    InitAudioDevice();
    defer CloseAudioDevice();

    SetTargetFPS(60);
    init_game_state();
    init_bullets();
    init_player();
    init_enemy_turret();

    change_game_state(GameState.Start);
    
    // spawn 2 for testing
    // spawn_enemy_turret(Vector2.{200, 100});
    // spawn_enemy_turret(Vector2.{300, 100});
    // spawn_enemy_turret(Vector2.{400, 100});

    while !WindowShouldClose()     // Detect window close button or ESC key
    {
        reset_temporary_storage();
        
        BeginDrawing();
        defer EndDrawing();

        ClearBackground(BLACK);

        draw_background();
        simulate_bullets();
        simulate_player();
        simulate_enemy_turrets();
        simulate_game_state();
    }
}







