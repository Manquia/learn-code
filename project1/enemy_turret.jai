
EnemyTurret :: struct
{
    pos: Vector2;
    radius: float;
    health: int;
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

    for *et :enemy_turret_instances
    {
        pos: Vector2;
        pos.x = et.pos.x + texture_offset.x;
        pos.y = et.pos.y + texture_offset.y;
        DrawTextureEx(enemy_turret_texture, pos, 0, scale, WHITE);

        // DEBUG
        DrawCircleSectorLines(et.pos, et.radius, 0, 360, 32, VIOLET);
    }
}



enemy_turret_texture: Texture2D;
enemy_turret_instances: [..]EnemyTurret;