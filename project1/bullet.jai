bullet_frames: [..]Texture2D;
init_bullets :: ()
{
    array_add(*bullet_frames, LoadTexture("resources/bullet_frame_0.png"));
    array_add(*bullet_frames, LoadTexture("resources/bullet_frame_1.png"));
    array_add(*bullet_frames, LoadTexture("resources/bullet_frame_2.png"));
    array_add(*bullet_frames, LoadTexture("resources/bullet_frame_3.png"));
}

Team :: enum
{
    Player :: 1;
    Enemy  :: 2;
}

Bullet :: struct
{
    pos:    Vector2;
    radius: float32; // @TODO
    birth:  float64;
    team:   Team;


    LIFESPAN :float64: 10.0;
}
bullet_instances: [..]Bullet;

spawn_player_bullet :: (position: Vector2)
{
    b: Bullet;

    b.pos = position;
    b.radius = 10;
    b.birth = GetTime();
    b.team = Team.Player;

    array_add(*bullet_instances, b);
}

simulate_bullets :: ()
{
    time := GetTime();
    dt := GetFrameTime();
    speed := dt * 250.0;

    texture_offset: Vector2;
    scale: float32 = 0.5;

    // Get bullet texture offset
    {
        first_frame: Texture2D = bullet_frames[0];
        texture_offset.x = -(first_frame.width  * 0.5 * scale);
        texture_offset.y = -(first_frame.height * 0.5 * scale);
    }

    for *bullet :bullet_instances
    {
        bullet.pos.y -= speed;

        frame_count := bullet_frames.count;
        bullet_time := time - bullet.birth;
        frame_period : float64 = 1.0/15.0;
        frame_index := round_to_nearest_int(bullet_time / frame_period) % frame_count;

        pos: Vector2;
        pos.x = bullet.pos.x + texture_offset.x;
        pos.y = bullet.pos.y + texture_offset.y;
        DrawTextureEx(bullet_frames[frame_index], pos, 0, scale, WHITE);
    }


    // for *bullet :bullet_instances
    // {
    //     remove; // removes bullet from the bullet_instances array
    //     continue;
    // }
}


round_to_nearest_int :: (f: float64) -> int
{
    return cast(int)(f + 0.5);

    // "->" cast to
    //
    // float32 -> int
    // 7.99999 -> 7
    // 7.51 -> 8
    // 7.49 -> 7

    // 7.49 + 0.5 = 7.99 -> 7
    // 7.51 + 0.5 = 8.01 -> 8
}

// 2) instances of the bullets