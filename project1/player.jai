

init_player :: ()
{
    width  := GetScreenWidth();
    height := GetScreenHeight();

    player.pos.x = width  * 0.5;
    player.pos.y = height * 0.8;

    player.radius = 15;
    player.health = 100;

    player.texture = LoadTexture("resources/player_texture.png");
}

simulate_player :: ()
{
    width  := GetScreenWidth();
    height := GetScreenHeight();

    speed := GetFrameTime() * 180.0;
    // Input
    if IsKeyDown(.KEY_RIGHT) || IsKeyDown(.KEY_D) player.pos.x += speed;
    if IsKeyDown(.KEY_LEFT)  || IsKeyDown(.KEY_A) player.pos.x -= speed;
    if IsKeyDown(.KEY_UP)    || IsKeyDown(.KEY_W) player.pos.y -= speed;
    if IsKeyDown(.KEY_DOWN)  || IsKeyDown(.KEY_S) player.pos.y += speed;

    if IsKeyPressed(.KEY_SPACE)
    {
        spawn_player_bullet(player.pos);
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


Player :: struct
{
    pos: Vector2;
    radius: float;
    health: int;

    texture: Texture2D;
}
player: Player;
