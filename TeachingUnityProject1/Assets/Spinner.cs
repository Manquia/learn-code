using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Spinner : MonoBehaviour
{
    // Update is called once per frame
    void Update()
    {
        float dt = Time.deltaTime;

        transform.localRotation *= Quaternion.AngleAxis(180.0f * dt, new Vector3(0,0,1));
    }
}
