using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GradualColorChange : MonoBehaviour
{
    public Gradient transitionColors;

    void Update()
    {
        float time = Time.timeSinceLevelLoad;
        time = time * 0.5f;
        Color sampledColor = transitionColors.Evaluate(time % 1.0f);

        GetComponent<SpriteRenderer>().color = sampledColor;
    }
}
