using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public static PlayerController singleton;
    public float speed = 5.0f;

    void OnEnable()
    {
        singleton = this;
    }
    void OnDisable()
    {
        singleton = null;
    }


    // Update is called once per frame
    void Update()
    {
        float dt   = Time.deltaTime;
        float dist = speed * dt;

        bool wantLeft  = Input.GetKey(KeyCode.LeftArrow);
        bool wantRight = Input.GetKey(KeyCode.RightArrow);
        bool wantUp = Input.GetKey(KeyCode.UpArrow);
        bool wantDown = Input.GetKey(KeyCode.DownArrow);

        Vector3 move = Vector3.zero;

        //        <condition> ? <true> : <false>;
        move.x += (wantLeft ) ? -dist : 0.0f;
        move.x += (wantRight) ? +dist : 0.0f;
        move.y += (wantDown ) ? -dist : 0.0f;
        move.y += (wantUp   ) ? +dist : 0.0f;

        Transform trans = GetComponent<Transform>();
        Vector3 pos = trans.position;
        trans.position = pos + move;
    }
}

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
