
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

            // Homework:
            // @TODO Display text explaining controls
            // @TODO press space to start the game

        case GameState.Loose;
            // You loose screen, Press space to try again?
        
        case GameState.Win;
            // You win, show credits, score, etc....
        
        case GameState.Gameplay;
            // Spawn enemies!

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
            enable_gameplay();
    }
}

enable_gameplay :: ()
{
    player.is_alive = true;
}

disable_gameplay :: ()
{
    array_reset_keeping_memory(*bullet_instances);
    array_reset_keeping_memory(*enemy_turret_instances);
    player.is_alive = false;
}

#scope_file
g_current_game_state : GameState = .None;
