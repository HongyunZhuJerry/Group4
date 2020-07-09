import Felgo 3.0
import QtQuick 2.0

EntityBase{
    entityId: "wall"
    entityType: "wall"

    property alias boxCollider: boxCollider

    signal wallHitted
    BoxCollider{
        id:boxCollider

        bodyType: Body.Static
        fixture.onBeginContact: wallHitted()
    }
}
