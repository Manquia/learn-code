using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Collider2D)),
 RequireComponent(typeof(SpriteRenderer)),
 RequireComponent(typeof(AudioSource))]
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

        // Change state of coin to pick it up!
        GetComponent<SpriteRenderer>().enabled = false;
        GetComponent<Collider2D>().enabled = false;
        GetComponent<AudioSource>().Play();
    }
}
