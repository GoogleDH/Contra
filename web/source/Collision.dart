part of contra;

class Collision {
  isCollided(Object object1, Object object2) {

  }
  
  
  //also need "current" position, to calculate the direction having collision
  static int isCollidedWithTerrain(Object obj, double oldX, double oldY){
    List<Tile> bricks = Game.worldMap.bricks;
    if(bricks == null) return 0;
    int result = 0;
    for(Tile o in bricks){
      int c = obj.collisionWithDirection(o, oldX, oldY); 
      if(c > 0){
        //print("Collided! $c : "+ obj.toString()+ " with " + o.toString() + " oldX = " + oldX.toString() + " oldY = " + oldY.toString());
        result |= c;
      }
    }
    return result;
  }
  
  static Tile hasSomethingToStandOn(Object obj){
    List<Tile> bricks = Game.worldMap.bricks;
    if(bricks == null) return null;
    for(Tile o in bricks){
      if(o.y >= obj.y + obj.height && o.y <= obj.y + obj.height + obj.speedY && 
          !(obj.x + obj.width < o.x || obj.x > o.x + o.width)) {
        return o;
      }
    }
    return null;
  }
  
  static bool reachedEnd(Player player) {
    List<Tile> bricks = Game.worldMap.ends;
    if(bricks == null) return false;
    for(Tile o in bricks){
      int c = player.collision(o);
      if(c > 0){
//        print("Collided! $c : "+ obj.toString()+ " with " + o.toString() + " oldX = " + oldX.toString() + " oldY = " + oldY.toString());
        return true;
      }
    }
    return false;
  }
}

