// unsigned Integer                                                              Range          state count
u8    00000000                                                                // 0,255         (256)     
u16   00000000 00000000                                                       // 0,65353       (2^16)    
u32   00000000 00000000 00000000 00000000                                     // 0,(2^32) - 1  (2^32)
u64   00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 // 0,(2^64) - 1  (2^64)

// signed Integer                                                                 Range              state count
s8    10000000                                                                // -128,    + 127      (256)     
s16   00000000 00000000                                                       // -32768,  +32767     (2^16)    
s32   00000000 00000000 00000000 00000000                                     // -(2^31), +(2^32) -1 (2^32)
s64   00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 // -(2^63), +(2^63) -1 (2^64)

// Signed Real 0.3 = 1/3
float32 00000000 00000000 00000000 00000000
float64 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000

bool = s8  is true when > 0. is false when == 0

name: string = "Hey";
name.data       ^
name.count = 3

"Hey"
72 101 121

Frust :: 2345; // Number

Fruit :: struct
{
    name: string;
    color: float;  // gray-scale 0-1, Black to White
    weight: float; // kg
    taste: string = "Sweet";
}

Vector2 :: struct
{
    x: float;
    y: float;
}

PhsyicsDetail :: struct
{
    position: Vector2;
    velocity: Vector2;
    boucy: float;
    friction: float;
}

Goblin :: struct
{
    physics: PhsyicsDetail;

    height: float;
    strength: int;
    health:   int;
}

WolfRidder :: struct
{
    physics: PhsyicsDetail;

    height: float;
    strength: int;
    health:   int;
}





















