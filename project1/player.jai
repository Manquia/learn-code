

init_player :: ()
{
    player.is_alive = true;

    width  := GetScreenWidth();
    height := GetScreenHeight();

    player.pos.x = width  * 0.5;
    player.pos.y = height * 0.8;

    player.radius = 15;
    player.health = 100;

    player.last_shot_time = GetTime();
    player.rate_of_fire   = 0.28;

    player.texture = LoadTexture("resources/player_texture.png");
}

simulate_player :: ()
{
    // Do not simulate the player if they are not alive
    if player.is_alive == false
    {
        return;
    }

    width  := GetScreenWidth();
    height := GetScreenHeight();
    time   := GetTime();

    dt := GetFrameTime();
    speed := dt * 180.0;
    // Input
    if IsKeyDown(.KEY_RIGHT) || IsKeyDown(.KEY_D) player.pos.x += speed;
    if IsKeyDown(.KEY_LEFT)  || IsKeyDown(.KEY_A) player.pos.x -= speed;
    if IsKeyDown(.KEY_UP)    || IsKeyDown(.KEY_W) player.pos.y -= speed;
    if IsKeyDown(.KEY_DOWN)  || IsKeyDown(.KEY_S) player.pos.y += speed;

    if IsKeyDown(.KEY_SPACE) && can_player_shoot()
    {
        is_powerup_active: bool = true;

        if is_powerup_active
        {
            BULLET_VELOCITY :: Vector2.{ 0, -550};

            spawn_player_bullet(player.pos,                      BULLET_VELOCITY);
            spawn_player_bullet(player.pos + Vector2.{-10, +10}, BULLET_VELOCITY); // bot left
            spawn_player_bullet(player.pos + Vector2.{+10, +10}, BULLET_VELOCITY); // bot right
        }
        else
        {
            BULLET_VELOCITY :: Vector2.{ 0, -250};
            spawn_player_bullet(player.pos, BULLET_VELOCITY);
        }


        player.last_shot_time = time;
    }

    // Bounds check
    {
        player.pos.x = clamp(player.pos.x, 0, xx width);
        player.pos.y = clamp(player.pos.y, 0, xx height);
    }

    // Draw player
    {
        scale: float = 0.2;
        pos: Vector2;
        pos.x = player.pos.x - (player.texture.width  * 0.5 * scale);
        pos.y = player.pos.y - (player.texture.height * 0.5 * scale);
     
        DrawTextureEx(player.texture, pos, 0, scale, WHITE);
        
        // DEBUG
        DrawCircleSectorLines(player.pos, player.radius, 0, 360, 32, WHITE);
    }

    // Draw fireball
    {   
        RAD_TO_DEG :: 180.0 / Math.PI;
        DEG_TO_RAD :: Math.PI / 180.0;

        scale: float = 0.2;
        pos: Vector2;
        fire_ball_texture := bullet_frames[0];
        fire_ball_texture_offset: Vector2;
        fire_ball_texture_offset.x = - (fire_ball_texture.width  * 0.5 * scale);
        fire_ball_texture_offset.y = - (fire_ball_texture.height * 0.5 * scale);
        
        oribit_offset := Vector2.{0, 50};
        pos.x = player.pos.x + oribit_offset.x;
        pos.y = player.pos.y + oribit_offset.y;
        
        fireball_1 := rotate_about_origin(pos, player.pos, (cast(float)time * 700.0 + 000) * DEG_TO_RAD);
        fireball_2 := rotate_about_origin(pos, player.pos, (cast(float)time * 700.0 + 120) * DEG_TO_RAD);
        fireball_3 := rotate_about_origin(pos, player.pos, (cast(float)time * 700.0 + 240) * DEG_TO_RAD);

        fireball_1 = fireball_1 + fire_ball_texture_offset;
        fireball_2 = fireball_2 + fire_ball_texture_offset;
        fireball_3 = fireball_3 + fire_ball_texture_offset;

        DrawTextureEx(fire_ball_texture, fireball_1, 0, scale, WHITE);
        DrawTextureEx(fire_ball_texture, fireball_2, 0, scale, WHITE);
        DrawTextureEx(fire_ball_texture, fireball_3, 0, scale, WHITE);
    }
}

damage_player :: (ammount: int)
{
    player.health -= ammount;

    if player.health <= 0
    {
        player.is_alive = false;
        change_game_state(GameState.Loose);
    }
}

can_player_shoot :: () -> bool
{
    time :float64 = GetTime();
    time_since_last_shot :float64 = time - player.last_shot_time;

    if time_since_last_shot >= player.rate_of_fire
    {
        return true;
    }
    else
    {
        return false;
    }
}


Player :: struct
{
    pos: Vector2;
    radius: float;
    health: int;
    texture: Texture2D;

    last_shot_time: float64;
    rate_of_fire: float64; 

    is_alive: bool;
}
player: Player;
