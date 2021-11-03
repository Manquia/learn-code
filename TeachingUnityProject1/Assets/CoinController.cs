using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CoinController : MonoBehaviour
{
    public float weight = 0.1f;
    public int value = 5;


    private void OnTriggerEnter2D(Collider2D collision)
    {
        var player = collision.GetComponent<DynamicPlayerController>();

        // Return if the collider entering the trigger was not a
        // player then we can return here.
        if (player == null)
        {
            return;
        }

        player.PickupCoin(this);
    }
}
