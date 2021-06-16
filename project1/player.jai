

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

    speed := GetFrameTime() * 180.0;
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
            spawn_player_bullet(player.pos);
            spawn_player_bullet(player.pos + Vector2.{-10, +10}); // bot left
            spawn_player_bullet(player.pos + Vector2.{+10, +10}); // bot right
        }
        else
        {
            spawn_player_bullet(player.pos);
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
}

damage_player :: (ammount: int)
{
    player.health -= ammount;

    if player.health <= 0
    {
        player.is_alive = false;
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
