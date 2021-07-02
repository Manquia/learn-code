
EnemyTurret :: struct
{
    pos: Vector2;
    radius: float;
    health: int;
    last_shot_time: float64;
    rate_of_fire: float64; 
}

init_enemy_turret :: ()
{
    enemy_turret_texture = LoadTexture("resources/player_texture.png");
}

spawn_enemy_turret :: (position: Vector2)
{
    et: EnemyTurret;

    et.pos = position;
    et.radius = 32;
    et.health = 200;
    et.last_shot_time = GetTime();
    et.rate_of_fire = 1.5;

    array_add(*enemy_turret_instances, et);
}

simulate_enemy_turrets :: ()
{
    texture_offset: Vector2;
    scale: float32 = 0.2;

    // Get enemy turret texture offset
    {
        texture_offset.x = -(enemy_turret_texture.width  * 0.5 * scale);
        texture_offset.y = -(enemy_turret_texture.height * 0.5 * scale);
    }

    // draw turrets
    for *et :enemy_turret_instances
    {
        vecToPlayer : Vector2 = player.pos - et.pos;
        vecToPlayerNorm : Vector2 = Vector2Normalize(vecToPlayer);

        RAD_TO_DEG :: 180.0 / Math.PI;
        DEG_TO_RAD :: Math.PI / 180.0;
        angle_radians : float = Math.atan2(vecToPlayerNorm.y, vecToPlayerNorm.x) - (Math.PI / 2.0);
        angle_degrees : float = angle_radians * RAD_TO_DEG;
        
        offset_rotation := calculate_rotated_offset(texture_offset, angle_radians);

        pos: Vector2;
        pos.x = et.pos.x + offset_rotation.x;
        pos.y = et.pos.y + offset_rotation.y;
        DrawTextureEx(enemy_turret_texture, pos, angle_degrees, scale, WHITE);

        // DEBUG
        // DrawCircleSectorLines(et.pos, et.radius, 0, 360, 32, VIOLET);
    }

    // Shoot at player
    time: float64 = GetTime();
    for *et :enemy_turret_instances
    {
        time_since_last_shot :float64 = time - et.last_shot_time;

        if time_since_last_shot >= et.rate_of_fire
        {
            vecToPlayer : Vector2 = player.pos - et.pos;
            vecToPlayerNorm : Vector2 = Vector2Normalize(vecToPlayer);
            bullet_velocity : Vector2 = vecToPlayerNorm * 280.0;

            spawn_enemey_turret_bullet(et.pos, bullet_velocity);
            et.last_shot_time = time;
        }
    }
}



enemy_turret_texture: Texture2D;
enemy_turret_instances: [..]EnemyTurret;