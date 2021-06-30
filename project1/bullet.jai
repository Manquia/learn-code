bullet_frames: [..]Texture2D;
init_bullets :: ()
{
    array_add(*bullet_frames, LoadTexture("resources/bullet_frame_0.png"));
    array_add(*bullet_frames, LoadTexture("resources/bullet_frame_1.png"));
    array_add(*bullet_frames, LoadTexture("resources/bullet_frame_2.png"));
    array_add(*bullet_frames, LoadTexture("resources/bullet_frame_3.png"));

    bullet_fire_wave  = LoadWave("resources/sound.wav");
    bullet_fire_sound = LoadSoundFromWave(bullet_fire_wave);
    //bullet_fire_sound = LoadSoundFromWave(bullet_fire_wave);
}

Team :: enum
{
    Player :: 1;
    Enemy  :: 2;
}

Bullet :: struct
{
    pos:      Vector2;
    velocity: Vector2;

    radius:   float32;
    birth:    float64;
    team:     Team;
    damage:   int;      // The ammount of damage done when colliding with a different team.

    LIFESPAN :float64: 10.0;
}
bullet_instances: [..]Bullet;
bullet_fire_sound: Sound;
bullet_fire_wave: Wave;

spawn_player_bullet :: (position: Vector2, initial_velocity: Vector2)
{
    b: Bullet;

    b.pos = position;
    b.velocity = initial_velocity;
    b.radius = 10;
    b.birth = GetTime();
    b.team = Team.Player;
    b.damage = 75;

    // PlaySound(bullet_fire_sound);

    array_add(*bullet_instances, b);
}

spawn_enemey_turret_bullet :: (position: Vector2, initial_velocity: Vector2)
{
    b: Bullet;

    b.pos = position;
    b.velocity = initial_velocity;
    b.radius = 10;
    b.birth = GetTime();
    b.team = Team.Enemy;
    b.damage = 69;

    // PlaySound(bullet_fire_sound);

    array_add(*bullet_instances, b);
}

simulate_bullets :: ()
{
    //print("IsSoundPlaying: %\n", IsSoundPlaying(bullet_fire_sound));

    physics_bullets();
    draw_bullets();
}

physics_bullets :: ()
{
    for *bullet :bullet_instances
    {
        end_bullet: bool;

        if bullet.team == Team.Player
        {
            for *et :enemy_turret_instances
            {
                if overlapping_cirles(bullet.pos, bullet.radius, et.pos, et.radius)
                {
                    et.health -= bullet.damage;
                    end_bullet = true;

                    if et.health <= 0
                    {
                        remove; // remove et
                    }
                    break;
                }
            }
        }

        if bullet.team == Team.Enemy
        {
            if overlapping_cirles(bullet.pos, bullet.radius, player.pos, player.radius)
            {
                damage_player(bullet.damage);
                end_bullet = true;
            }
        }


        if end_bullet
        {
            remove; // remove bullet
        }
    }
}

draw_bullets :: ()
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
        // Move bullet by it's velocity
        bullet.pos = bullet.pos + bullet.velocity * dt;

        frame_count := bullet_frames.count;
        bullet_time := time - bullet.birth;
        frame_period : float64 = 1.0/15.0;
        frame_index := round_to_nearest_int(bullet_time / frame_period) % frame_count;

        if bullet_time > Bullet.LIFESPAN
        {
            remove;
            continue;
        }

        pos: Vector2;
        pos.x = bullet.pos.x + texture_offset.x;
        pos.y = bullet.pos.y + texture_offset.y;
        DrawTextureEx(bullet_frames[frame_index], pos, 0, scale, WHITE);

        
        // DEBUG
        DrawCircleSectorLines(bullet.pos, bullet.radius, 0, 360, 32, WHITE);
    }
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