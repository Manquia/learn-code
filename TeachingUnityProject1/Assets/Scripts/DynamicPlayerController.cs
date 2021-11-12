using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//
// Homework: Make it so that we can do Kirby!!!
// Homework: Code Signal Arcade Intro 4,5,6,8
//

/*
Balloon game
- How do we collet them? Are they inflated?

Goal: 
Collect as much gold and reach the top floor in
this collectors dream platformer.

Move Systems: Character progression (ie. Unlocking movement abilities)
- Basics
-- A + D: Left and right movement. 
-- Space: Jump
-- Shift: Sprint
- Balloon Specific
-- Having Balloons grants slow fall (changes to riseing power, eventually)
Advanced: (Maybe)
- Grappling hooks
-- Fishing pole? (Fix soft-lock with being stuck on the ceiling)
- Double Jump
- Dash + Wave Dash

Enemies
- Dart trap (hole in the wall)
- Spikes
- Acid droplets
- Pressure plates
-- Trap door?
-- Triggers Traps?
-- Affected by your weight?

Items:
- Balloons
-- Can be popped
- Gold Bars
-- Heavy!
-- Points!
*/

public class DynamicPlayerController : MonoBehaviour
{
    public static DynamicPlayerController g_singleton;
    void OnEnable()
    {
        g_singleton = this;
    }
    void OnDisable()
    {
        g_singleton = null;
    }

    public float horizontalAcceleration = 20.0f;
    public float jumpAcceleration       = 20.0f;
    public float maxHorizontalMovementVelocity = 7.0f;
    public float maxDistanceFromGroundJumping  = 0.2f;

    public   int multiJumpCount = 3;
    internal int multiJumps = 0;

    public   float multiJumpChargeResetTimer = 0.2f;
    internal float lastMultiJumpTime = 0;




    // Update is called once per frame
    void Update()
    {
        UpdatePlayerMovement();
    }

    void UpdatePlayerMovement()
    {
        float dt = Time.fixedDeltaTime; // fixedDeltaTime is the physics's system's delta time used. This doesn't match the game's FPS.

        bool wantLeft  = Input.GetKey(KeyCode.LeftArrow)   || Input.GetKey(KeyCode.A);
        bool wantRight = Input.GetKey(KeyCode.RightArrow)  || Input.GetKey(KeyCode.D);
        bool wantJump  = Input.GetKeyDown(KeyCode.UpArrow) || Input.GetKeyDown(KeyCode.Space)  || Input.GetKeyDown(KeyCode.W);

        float timeSinceLastMuiltiJump = Time.time - lastMultiJumpTime;
        bool canResetJumps = timeSinceLastMuiltiJump > multiJumpChargeResetTimer;

        bool isGrounded = IsGrounded();
        if (isGrounded && canResetJumps)
        {
            multiJumps = 0; // reset all jump charges
        }
        bool canJump = multiJumps < multiJumpCount;

        Vector2 velocityDelta = Vector2.zero;
        // Calculate how much velocity we could possibly change in this frame
        {
            if (wantLeft)
            {
                velocityDelta += Vector2.left * horizontalAcceleration * dt;
            }
            if (wantRight)
            {
                velocityDelta += Vector2.right * horizontalAcceleration * dt;
            }

            if (!wantLeft && !wantRight) // Slow DOWN in the x direction
            {
                // @TODO
            }

            if (wantJump && canJump)
            {
                multiJumps += 1; // spend a jump charge
                lastMultiJumpTime = Time.time; // GetTime()
                velocityDelta += Vector2.up * jumpAcceleration;
            }
        }

        // Apply velocity directly
        {
            Rigidbody2D rigid = GetComponent<Rigidbody2D>();
            Vector2 oldVelocity = rigid.velocity;

            // Don't allow velocity change to exceed the maxHorizontalMovementVelocity
            //                  -M    OV      0              +M
            //            --------------------+--------------------------
            //
            float maxIncreaseNegative = Mathf.Min(-maxHorizontalMovementVelocity - oldVelocity.x, 0.0f);
            float maxIncreasePositive = Mathf.Max(+maxHorizontalMovementVelocity - oldVelocity.x, 0.0f);
            velocityDelta.x = Mathf.Clamp(velocityDelta.x, maxIncreaseNegative, maxIncreasePositive);
            rigid.velocity = oldVelocity + velocityDelta;
        }


    }

    private bool IsGrounded()
    {
        CapsuleCollider2D capsule = GetComponent<CapsuleCollider2D>();
        float height = capsule.size.y;

        Vector2 dir = Vector2.down;
        Vector2 origin = transform.position;
        origin.y -= (height / 2.0f) * 1.01f;

        var hit = PlayerRaycast(origin, dir, maxDistanceFromGroundJumping);

        if (hit.collider != null)
        {
            return true;
        }

        return false;
    }

    private RaycastHit2D PlayerRaycast(Vector2 origin, Vector2 direction, float distance)
    {
        RaycastHit2D hit = Physics2D.Raycast(origin, direction, distance);

        Debug.DrawLine(origin, origin + (direction * distance), Color.white);

        return hit;
    }

    void UpdatePlayerForcesMovement()
    {
        float dt = Time.fixedDeltaTime; // fixedDeltaTime is the physics's system's delta time used. This doesn't match the game's FPS.

        bool wantLeft = Input.GetKey(KeyCode.LeftArrow)   || Input.GetKey(KeyCode.A);
        bool wantRight = Input.GetKey(KeyCode.RightArrow) || Input.GetKey(KeyCode.D);
        bool wantJump = Input.GetKeyDown(KeyCode.Space)   || Input.GetKeyDown(KeyCode.W);

        Rigidbody2D rigid = GetComponent<Rigidbody2D>();
        Vector2 oldVelocity = rigid.velocity;

        Vector2 velocityDelta = Vector2.zero;
        // Calculate how much velocity we could possibly change in this frame
        {
            if (wantLeft)
            {
                velocityDelta += Vector2.left * horizontalAcceleration * dt;
            }
            if (wantRight)
            {
                velocityDelta += Vector2.right * horizontalAcceleration * dt;
            }

            if (wantJump) // @TODO canJump/Grounded
            {
                velocityDelta += Vector2.up * jumpAcceleration;
            }
        }

        // Apply velocity directly
        {

            // Don't allow velocity change to exceed the maxHorizontalMovementVelocity
            //                  -M    OV      0              +M
            //            --------------------+--------------------------
            //
            float maxIncreaseNegative = -maxHorizontalMovementVelocity - oldVelocity.x;
            float maxIncreasePositive =  maxHorizontalMovementVelocity - oldVelocity.x;
            velocityDelta.x = Mathf.Clamp(velocityDelta.x, maxIncreaseNegative, maxIncreasePositive);
            rigid.velocity = oldVelocity + velocityDelta;
        }
    }




    internal int coinCount = 0;
    public void PickupCoin(CoinController coin)
    {
        // get player's RigidBody2D
        var rigidBody = GetComponent<Rigidbody2D>();

        // Increase mass
        rigidBody.mass += coin.weight;  
        // Add the coin's value
        coinCount += coin.value;
    }

}
