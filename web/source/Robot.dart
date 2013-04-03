part of contra;

class Robot extends Object implements Animatable {
  Bitmap bitmap = new Bitmap(new BitmapData(40, 80, false, Color.Black));
  
  double speedX;
  double speedY;
  static int TYPE_JUMPPING = 0;
  static int TYPE_SHOOTING = 1;
  bool isDead = false;
  int type;
  
  math.Random random = new math.Random(new DateTime.now().millisecondsSinceEpoch);

  Robot(int type, double x, double y) {
    // Set speed according to type
    bitmap.x = x;
    bitmap.y = (Statics.BACKGROUND_HEIGHT - Statics.TILE_SIZE - 80);
    this
      ..addChild(bitmap)
      ..type = type
      ..x = x + Game.displayWindow.x
      ..y = y
      ..speedX = 100.0
      ..speedY = 0.0
      ..width = bitmap.width
      ..height = bitmap.height;
    
    
    juggler.add(this);
  }
  
  destroy() {
    juggler.remove(this); 
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
    
    if(random.nextDouble() > 0.97) {
      Game.bulletManager.robotFired(this);
    }
    
    // Set action according to different type
    if (type == Robot.TYPE_JUMPPING) {
      // update x,y,speedX/Y
    } else if (type == Robot.TYPE_SHOOTING) {
      // shoot
    }
    
    
    // CollisionManager.checkPlayer(this);
    // CollisionManager.checkRobot(this);
    
  }
  
  setDead() {
    this.isDead = true;
  }
}

