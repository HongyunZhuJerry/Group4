import Felgo 3.0
import QtQuick 2.0

EntityBase {
    entityType: "dog"

    signal dogHitted
    signal catlaugh

    BoxCollider{
        id:boxCollider
        width:40
        height: 40

        //dog is static
        bodyType: Body.Static

        fixture.onBeginContact:{
            catlaugh()
            dogHitted()
        }
    }


}
