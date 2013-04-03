part of contra;

class Collision {
  isCollided(Object object1, Object object2) {

  }
  
  
  //also need "current" position, to calculate the direction having collision
  static int isCollidedWithTerrain(Object obj){
    List<Tile> bricks = Game.worldMap.bricks;
    if(bricks == null) return 0;
    for(Tile o in bricks){
      int result = o.collision(obj); 
      if(result > 0){
        print("Collided! $result : "+ obj.toString()+ " with " + o.toString());
        return result;
      }
    }
    return 0;
  }
  
  static Tile hasSomethingToStandOn(Object obj){
    List<Tile> bricks = Game.worldMap.bricks;
    if(bricks == null) return null;
    for(Tile o in bricks){
      if(o.y >= obj.y + obj.height && o.y <= obj.y + obj.height + obj.speedY && 
          ((obj.x + obj.width > o.x && obj.x < o.x) || (obj.x < o.x + o.width && obj.x > o.x)) ){
        return o;
      }
    }
    return null;
  }
}

