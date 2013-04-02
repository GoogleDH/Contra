part of contra;

class Robot extends Object implements Animatable {
  
  static int TYPE_JUMPPING = 0;
  static int TYPE_SHOOTING = 1;
  
  int type;
  
  Robot(int type, double x, double y) {
    // Set speed according to type
    this.type = type;
    this.x = x;
    this.y = y;
    // this.speedX = 1;
    // this.speedY = 10;
  }
  
  destroy() {
    
  }
  
  bool advanceTime(num time) {
    // Set action according to different type
    if (type == Robot.TYPE_JUMPPING) {
      // update x,y,speedX/Y
    } else if (type == Robot.TYPE_SHOOTING) {
      // shoot
    }
  }
  
}

