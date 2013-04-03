part of contra;

class Collision {
  isCollided(Object object1, Object object2) {

  }
  
  
  static bool isCollidedWithTerrain(Object obj){
    List<Tile> bricks = Game.worldMap.bricks;
    if(bricks == null) return false;
    for(Object o in bricks){
      if(o.collision(obj)){
        print("Collided!"+ obj.toString()+ " with " + o.toString());
        return true;
      }
    }
    return false;
  }
  
}

