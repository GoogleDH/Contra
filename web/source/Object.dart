part of contra;

class Object extends Sprite {
  // absolute position to the world;
  double x;
  double y;

  double width;
  double height;

  double speedX;
  double speedY;
  
  int direction; // 1 = left; -1 = right
  Object(){}
  
  // 0 for not colliding
  // 1 for collide on x axis only
  // 2 for collide on y axis only
  // 3 for collide on both x and y axises
  int collisionWithDirection(Object other, double oldX, double oldY) {
    int xAxis = collisionXY(x, oldY, other) != 0 ? 1 : 0;
    int yAxis = collisionXY(oldX, y, other) != 0 ? 2 : 0;
    return xAxis + yAxis;
  }
  
  int collision(Object other) {
    return collisionXY(x, y, other);
  }
  
  int collisionXY(double x, double y, Object other) {
    return x < other.x + other.width
        && x + width > other.x
        && y < other.y + other.height
        && y + height > other.y ? 1 : 0;
  }
  
  String toString(){
    return "{X: "+ x.toStringAsFixed(2)
        + ", Y: "+ y.toStringAsFixed(2)+ 
        ", width: "+ width.toStringAsFixed(2)
        + ", height: "+ height.toStringAsFixed(2)
        + ", speedX: "+ speedX.toStringAsFixed(2)
        + ", speedY: "+ speedY.toStringAsFixed(2)
        +"}";
  }
}

