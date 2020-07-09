import Felgo 3.0
import QtQuick 2.0
import "../scenes"

EntityBase{
    id:object
    entityType: "object"
    x:start.x
    y:start.y
    z:1

    //Press time, convert press time to speed
    property int time
    //Determine which scene creates the entity
    property int isWitch:1
    //The original position of the entity
    property point start
    //Who created the entity
    property string who
    //Physical velocity
    property point velocity:Qt.point(20+time*45,-50-time*65)
//    opacity: 0
//    property alias imgSource: ob.source


    BoxCollider{
        id:boxCollider

        fixture.friction: 1


        fixture.onBeginContact: {
            if(isWitch){
                if(isBomb==1) {
                    isBomb=0
                }
            }else{
                //Detect colliding objects
                var collidedEntity = other.getBody().target;
                var otherEntityId = collidedEntity.entityId;
                //Cats or dogs will lose their health as long as they are smashed (including smashing themselves~)
                if(otherEntityId.substring(0, 4) === "cat1"){
//                    if(who=="dog") catlife--
                    catlife--
                }else if(otherEntityId.substring(0, 4) === "dog1"){
//                    if(who=="cat") doglife--
                    doglife--
                }
            }

            object.destroy()
        }

    }

    Image {
        id: ob
        source: {
            if(who=="cat"){
                if(isWitch==0){
                    "../../assets/img/image_box.png"
                }else{
                    if(isBomb==1){
                        "../../assets/img/image_bomb_3.png"
                    }else{
                        "../../assets/img/image_box.png"
                    }
                }
             }else{
                if(isWitch==0){
                    "../../assets/img/image_bone.png"
                }else{
                    if(isBomb==1){
                        "../../assets/img/image_bomb_2.png"
                    }else{
                        "../../assets/img/image_bone.png"
                    }
                }

             }
        }
        width: 20
        height: 15
        anchors.fill: boxCollider

    }

    Component.onCompleted:{
        if(who=="cat") velocity.x=velocity.x
        else velocity.x=-velocity.x
        //Launching entity
        boxCollider.applyLinearImpulse(boxCollider.body.toWorldVector(velocity),boxCollider.body.getWorldCenter)
    }


}
