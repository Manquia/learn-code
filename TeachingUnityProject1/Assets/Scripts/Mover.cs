using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Mover : MonoBehaviour
{
    public Vector3 startPosition;
    public Vector3 endPosittion;
    public float moveSpeed;
    public float distanceTraveledForward;
    public bool isActive;
    public bool isMovingForward;

    private void FixedUpdate()
    {
        if (isActive == false) return;

        Vector3 forwardVector = endPosittion - startPosition;
        Vector3 backwardVector = -forwardVector;

        Vector3 forwardDirection = forwardVector.normalized;
        Vector3 backwardDirection = backwardVector.normalized;

        float dt = Time.fixedDeltaTime;

        float distanceTravledThisFrame = moveSpeed * dt;

        Vector3 forwardMovement = forwardDirection * distanceTravledThisFrame;
        Vector3 backwardMovement = backwardDirection * distanceTravledThisFrame;

        Vector3 position = transform.position;
        if (isMovingForward)
        {
            transform.position = position + forwardMovement;
            distanceTraveledForward += distanceTravledThisFrame;
        }
        else // moving backward
        {
            transform.position = position + backwardMovement;
            distanceTraveledForward -= distanceTravledThisFrame;
        }

        if (distanceTraveledForward > forwardVector.magnitude) // Reached end?
        {
            isMovingForward = false;
        }
        if (distanceTraveledForward < 0.0f) // Reached start
        {
            isMovingForward = true;
        }
    }

}
