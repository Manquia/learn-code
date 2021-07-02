
#load "../raylib.jai";

main :: () 
{
    // Initialization
    //--------------------------------------------------------------------------------------
    screenWidth :: 800;
    screenHeight :: 450;

    InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window");
    defer CloseWindow();

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------
    
    InitAudioDevice();
    defer CloseAudioDevice();

    bullet_fire_wave:Wave   = LoadWave("resources/sound.wav");
    bullet_fire_sound:Sound = LoadSoundFromWave(bullet_fire_wave);
    // bullet_fire_sound:Sound = LoadSound("resources/target.ogg");
    SetMasterVolume(0.75);
    SetSoundVolume(bullet_fire_sound, 1.0);
    defer UnloadSound(bullet_fire_sound);


    // Main game loop
    while !WindowShouldClose()     // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------
        if IsKeyPressed(.KEY_SPACE) then PlaySound(bullet_fire_sound);
    
        // Draw
        //----------------------------------------------------------------------------------
        {
            BeginDrawing();
            defer EndDrawing();

            ClearBackground(RAYWHITE);

            DrawText("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY);
        }
        //----------------------------------------------------------------------------------
    }


}