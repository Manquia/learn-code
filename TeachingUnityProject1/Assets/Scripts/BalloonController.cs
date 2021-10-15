using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BalloonController : MonoBehaviour
{
    void OnTriggerEnter2D(Collider2D collision)
    {
        DynamicPlayerController player = collision.GetComponent<DynamicPlayerController>();

        // We only care about things that enter our trigger volume when they have a DynamicPlayerController
        // (ie. a Player) that is part of that game object.
        if (player == null)
        {
            return;
        }

        // We only care about setting our connectedBody if it does not already
        // have a refernece to a rigid body.
        SpringJoint2D balloonSpringJoint = this.GetComponent<SpringJoint2D>();
        if (balloonSpringJoint.connectedBody != null)
        {
            return;
        }


        Rigidbody2D playerRigidBody = player.GetComponent<Rigidbody2D>();
        balloonSpringJoint.connectedBody = playerRigidBody;
        balloonSpringJoint.connectedAnchor = Vector2.up * 0.4f;
    }
}
