

calculate_rotated_offset :: (texture_offset: Vector2, angle_radians: float) -> rotation_offset: Vector2
{
    rotation_offset: Vector2;
    {
        rotation_offset.x = (texture_offset.x * Math.cos(angle_radians)) - (texture_offset.y * Math.sin(angle_radians));
        rotation_offset.y = (texture_offset.x * Math.sin(angle_radians)) + (texture_offset.y * Math.cos(angle_radians));
    }
    return rotation_offset;
}

rotate_about_origin :: (position: Vector2, origin: Vector2, angle_radians: float) -> rotated_point: Vector2
{
    pos_relative := position - origin;
    
    rotated_pos: Vector2;
    {
        rotated_pos.x = (pos_relative.x * Math.cos(angle_radians)) - (pos_relative.y * Math.sin(angle_radians));
        rotated_pos.y = (pos_relative.x * Math.sin(angle_radians)) + (pos_relative.y * Math.cos(angle_radians));
    }

    return origin + rotated_pos;
}
