using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BalloonController : MonoBehaviour
{
    public Sprite ropeSprite;
    internal Transform ropeTrans;

    GameObject MakeRope()
    {
        GameObject ropeGo = new GameObject("rope");
        var ropeRend = ropeGo.AddComponent<SpriteRenderer>();
        ropeRend.sprite = ropeSprite;

        return ropeGo;
    }

    void OnEnable()
    {
        var ropeGo = MakeRope();
        ropeTrans = ropeGo.transform;
    }
    void OnDisable()
    {
        if (ropeTrans != null)
        {
            Destroy(ropeTrans.gameObject);
        }
    }

    private void Update()
    {
        SpringJoint2D spring = GetComponent<SpringJoint2D>();

        Vector3 startPoint = transform.position; // @TODO This should use the anchor point of the spring. @Later
        Vector3 endPoint;

        if (spring.connectedBody == null)
        {
            endPoint = spring.connectedAnchor;
        }
        else // assume that the connectedBody is the player
        {
            var pc = DynamicPlayerController.g_singleton;
            endPoint = pc.transform.position;
        }

        // Setup position
        var vecToEnd = endPoint - startPoint;
        var vecHalfToEnd = vecToEnd * 0.5f;
        var ropePosition = startPoint + vecHalfToEnd;
        ropeTrans.position = ropePosition;

        // Setup Rotation
        var vecToStart = -vecToEnd;
        float angleRad = Mathf.Atan2(-vecToStart.y, vecToStart.x);
        float angleDeg = angleRad * Mathf.Rad2Deg;
        var rotation = Quaternion.AngleAxis(angleDeg, Vector3.back);
        ropeTrans.rotation = rotation;

        // Setup Scale
        Vector3 newScale = new Vector3(
            vecToEnd.magnitude,   // x
            0.03f,                // y
            1.0f);                // z
        ropeTrans.localScale = newScale;
    }

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
