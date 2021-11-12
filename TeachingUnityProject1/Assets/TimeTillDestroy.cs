using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TimeTillDestroy : MonoBehaviour
{
    public float timeTillDestroy = 5.0f;
    internal float timeOfEnable = -1337.0f;

    void OnEnable()
    {
        timeOfEnable = Time.fixedTime;
    }

    void FixedUpdate()
    {
        var currentTime = Time.fixedTime;
        var timeSinceEnable = (currentTime - timeOfEnable);

        if (timeSinceEnable > timeTillDestroy)
        {
            Destroy(gameObject);
        }
    }
}

