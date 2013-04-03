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
  
  bool collision(Object other) {
    return x < other.x + other.width
        && x + width > other.x
        && y < other.y + other.height
        && y + height > other.y;
  }
  
  String toString(){
    return "{x: $x, y: $y, width: $width, height: $height}";
  }
}

