#import "Basic";


#import "raylib-jai";
#load "raylib/raymath.jai";
Math :: #import "Math";

#load "background.jai";
#load "player.jai";
#load "bullet.jai";
#load "enemy_turret.jai";
#load "utils.jai";
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
//     controller/input (DONE), hp (DONE), lives, art/sprite/texture(DONE), size (DONE), dodge/barrel roll?, 
//     weapons
//       Primary Fire 
//         Rate/cooldown, damage (DONE), size (DONE), speed (DONE)
//       Secondary Fire 
//         Rate/cooldown, damage, size, speed
//     movement
//       speed, velocity, 
//   enemy ships (2)
//     ai/behavior, art/texture, hp, weapons
//   elite ship (1)
//     ai/behavior, art/texture, hp, weapons
//   background (done)
//     art/texture,                    LATER: star particles?, paralaxed background?
//   



main :: ()
{
    InitWindow(800, 600, "Space Invaders");
    defer CloseWindow();

    InitAudioDevice();
    defer CloseAudioDevice();

    SetTargetFPS(60);
    init_bullets();
    init_player();
    init_enemy_turret();
    
    // spawn 2 for testing
    spawn_enemy_turret(Vector2.{200, 100});
    spawn_enemy_turret(Vector2.{300, 100});
    spawn_enemy_turret(Vector2.{400, 100});

    while !WindowShouldClose()     // Detect window close button or ESC key
    {
        if IsKeyPressed(.KEY_SPACE)
        {
            print("Playing Sound\n");
            PlaySound(bullet_fire_sound);
        }

        BeginDrawing();
        defer EndDrawing();

        ClearBackground(BLACK);

        draw_background();
        simulate_bullets();
        simulate_player();
        simulate_enemy_turrets();
    }
}







