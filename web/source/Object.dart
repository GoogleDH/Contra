part of contra;

abstract class Object extends Sprite {
  // absolute position to the world;
  double x;
  double y;
  
  double witdh;
  double height;
  
  double speedX;
  double speedY;
  
  int direction; // 1 = left; -1 = right
  
  bool collision(Object other) {
    print("${other.height} ${other.width}");
    return x < other.x + other.width
        && x + width > other.x
        && y < other.y + other.height
        && y + height > other.y;
  }
}

