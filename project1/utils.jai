

calculate_rotated_offset :: (texture_offset: Vector2, angle_radians: float) -> rotation_offset: Vector2
{
    rotation_offset: Vector2;
    {
        using texture_offset;
        rotation_offset.x = (x * Math.cos(angle_radians)) - (y * Math.sin(angle_radians));
        rotation_offset.y = (x * Math.sin(angle_radians)) + (y * Math.cos(angle_radians));
    }
    return rotation_offset;
}