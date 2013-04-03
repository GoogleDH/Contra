part of contra;

class Robot extends Object implements Animatable {
  Bitmap bitmap = new Bitmap(new BitmapData(40, 80, false, Color.Black));
  
  static int TYPE_JUMPPING = 0;
  static int TYPE_SHOOTING = 1;
  
  int type;
  
  math.Random random = new math.Random(new DateTime.now().millisecondsSinceEpoch);

  Robot(int type, double x, double y) {
    // Set speed according to type
    this.type = type;
    this.x = x;
    this.y = y;
    this.speedX = 100.0;
    this.speedY = 0.0;
    this.addChild(bitmap);
    juggler.add(this);
  }
  
  destroy() {
    
  }
  
  double shouldTurnAround = 0.0;
  
  bool advanceTime(num time) {
    shouldTurnAround += random.nextDouble();
    if( shouldTurnAround > 50 || shouldTurnAround < -50) {
      shouldTurnAround  = 0.0;
      speedX = - speedX;
    }
    
    
    x += speedX * time;
    y += speedY * time;
    //speedX += accelerationX * time;
    //speedY += accelerationY * time;

    bitmap.x = x - Game.displayWindow.x;
    bitmap.y = y;
    
    if(random.nextDouble() > 0.97) {
      Game.bulletManager.robotFired(this);
    }
    
    // Set action according to different type
    if (type == Robot.TYPE_JUMPPING) {
      // update x,y,speedX/Y
    } else if (type == Robot.TYPE_SHOOTING) {
      // shoot
    }
  }
  
}

