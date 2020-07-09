import Felgo 3.0
import QtQuick 2.0

EntityBase {
    signal doglaugh
    signal hitted

    entityType: "cat"

    signal catHitted()
//    BoxCollider{
//        id:boxCollider
//        width:50
//        height: 60

//        bodyType: Body.Static

//        fixture.onBeginContact: catHitted()
//    }

    PolygonCollider {
        id:boxCollider

        //cat is static
        bodyType: Body.Static
        vertices: [
            Qt.point(3,0),
            Qt.point(30,0),
            Qt.point(0,20),
            Qt.point(40,20)
        ]
        fixture.onBeginContact: {
            doglaugh()
            catHitted()
        }
    }



}
