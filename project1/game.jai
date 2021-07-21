
GameState :: enum
{
   None;
   Start;
   Loose;
   Win;
   Gameplay;
}

init_game_state :: ()
{

}

reset_game_state :: ()
{
    g_enemy_turrets_spawned = 0;
}

simulate_game_state :: ()
{
    width  := GetScreenWidth();
    height := GetScreenHeight();

    if #complete g_current_game_state ==
    {
        case;                assert(false, "This state is invalid!"); //  Do Nothing, default
        case GameState.None; assert(false, "This state is invalid!"); //  Do Nothing

        case GameState.Start;

            if IsKeyDown(.KEY_SPACE)
            {
                change_game_state(.Gameplay);
                return;
            }

            {
                text :: "Space Saga";
                font_size : s32 = 64;

                text_width := MeasureText(text, font_size);
                x := (width/2) - (text_width/2);
                DrawText(text, x, 100, font_size, WHITE);
            }

            {
                text :: "Controls";
                font_size : s32 = 48;

                text_width := MeasureText(text, font_size);
                x := (width/2) - (text_width/2);
                DrawText(text, x, 180, font_size, WHITE);
            }

            // @HOMEWORK @TODO
            // When kill_count reaches over 100. We should change into
            // the GameState.Win state so that we can stop the game
            // and congradulate the player on their accomplishments!
            //

            // @HOMEWORK @TODO
            // When the player has died. @See player.jai. We should
            // change into the GameState.Loose state so that we can
            // stop the game and barate the player for their failure.
            //

            // @HOMEWORK @TODO
            // When In GameState.Win and GameState.loose you should
            // be able to press spacebar to change into the GameState.Gameplay
            // state so the player can play the game again.

        case GameState.Loose;
            // You loose screen, Press space to try again?
        
        case GameState.Win;
            // You win, show credits, score, etc....
        
        case GameState.Gameplay;
            time := GetTime();
            width := GetScreenWidth();

            total_count   := g_enemy_turrets_spawned;
            current_count := enemy_turret_instances.count;
            kill_count    := total_count - current_count;

            // Display player's current kill count
            {
                displayText: string = tprint("Kills: %\0", kill_count);

                font_size : s32 = 32;
                DrawText(displayText.data, 15, 15, font_size, WHITE);
            }

            // Display player's health
            {
                displayText: string = tprint("Health: %1%%\0", player.health);

                font_size : s32 = 32;
                DrawText(displayText.data, 15, 62, font_size, WHITE);
            }

            max_allowed_on_screen := 5 + (kill_count / 3);

            can_spawn_enemy  : bool = (current_count < max_allowed_on_screen);
            is_spawning_time : bool = (xx time % 10) == 0;

            if (can_spawn_enemy && is_spawning_time)
            {
                // Get a random point within the top section of the screen
                spawn_pos: Vector2;
                spawn_pos.x = xx GetRandomValue(50, width - 50);
                spawn_pos.y = xx GetRandomValue(50, 300);

                spawn_enemy_turret(spawn_pos);
                g_enemy_turrets_spawned += 1;
            }

    }
}

change_game_state :: (new_game_state : GameState)
{
    g_current_game_state = new_game_state;

    if #complete new_game_state ==
    {
        case;                assert(false); //  Do Nothing, default
        case GameState.None; assert(false); //  Do Nothing

        case GameState.Start;
            disable_gameplay();

        case GameState.Loose;
            disable_gameplay();
        
        case GameState.Win;
            disable_gameplay();
        
        case GameState.Gameplay;
            reset_player();
            reset_game_state();
            enable_gameplay();
    }
}

enable_gameplay :: ()
{
}

disable_gameplay :: ()
{
    array_reset_keeping_memory(*bullet_instances);
    array_reset_keeping_memory(*enemy_turret_instances);
    player.is_alive = false;
}

#scope_file
g_current_game_state : GameState = .None;
g_enemy_turrets_spawned: int;
