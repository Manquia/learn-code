#import "Basic";


#load "raylib-jai/raylib.jai";
#load "background.jai";

// Project 1: Space Saga
// 
// Control a powerful ship in this top-down 2D shooter manuvering through enemy attacks
// while delivering devistating blows to the enemy fleet. Become wanted and the empire
// will send elite battleships to destoy you. Scavenge enemy wreckage to empower your arsence
// in this epic space saga.
//

// elements:
//   player ship
//     controller/input, hp, lives, art/sprite/texture, size, dodge/barrel roll?, 
//     weapons
//       Primary Fire
//         Rate/cooldown, damage, size, speed
//       Secondary Fire 
//         Rate/cooldown, damage, size, speed
//     movement
//       speed, velocity, 
//   enemy ships (2)
//     ai/behavior, art/texture, hp, weapons
//   elite ship (1)
//     ai/behavior, art/texture, hp, weapons
//   background 
//     art/texture,                    LATER: star particles?, paralaxed background?
//   



main :: ()
{
    InitWindow(800, 600, "window");
    defer CloseWindow();

    SetTargetFPS(60);

    while !WindowShouldClose()     // Detect window close button or ESC key
    {
        BeginDrawing();
        defer EndDrawing();

        ClearBackground(RAYWHITE);

        draw_background();
    }
}







