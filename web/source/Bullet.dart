part of contra;

class Bullet extends Object implements Animatable {
  double speedX;
  double speedY;
  double accelerationX;
  double accelerationY;

  bool dead_ = false;

  int direction;
  bool hostile; // hostile to player or not
  num duration; // seconds before it kills itself

  Bitmap bitmap;

  int type;
  math.Random random = new math.Random(new DateTime.now().millisecondsSinceEpoch);
  
  Bullet(double x, double y,
      double speedX, double speedY,
      double accelerationX, accelerationY,
      bool hostile, num duration) {
    type = 0;// bomb
    this.direction = speedX >= 0 ? 1 : -1;
    bitmap = new Bitmap(Grafix.resourceManager.getBitmapData(direction == 1 ? "bulletright" : "bulletleft"));
    this
      ..x = x
      ..y = y
      ..speedX = speedX
      ..speedY = -speedY
      ..accelerationX = accelerationX
      ..accelerationY = -accelerationY
      ..hostile = hostile
      ..duration = duration;
    
    if(!hostile && Game.keyboardHandler.isPressingUpKey()) {
      this.speedY -= 500.0;
    }
    if(!hostile && Game.keyboardHandler.isPressingDownKey()) {
      this.speedY += 300.0;
    }

    bitmap
      ..x = x - Game.displayWindow.x
      ..y = y
      ..scaleX = 0.15
      ..scaleY = 0.15;

    this.addChild(bitmap);
    juggler.add(this);
  }

  Bullet.gun(double x, double y,
         double speedX, double speedY,
         double accelerationX, accelerationY,
         bool hostile, num duration) {
    type = 1;//gun
    this.direction = speedX >= 0 ? 1 : -1;
    bitmap = new Bitmap(Grafix.resourceManager.getBitmapData(direction == 1 ? "bullet1Right" : "bullet1Left"));
    this
      ..x = x
      ..y = y
      ..speedX = speedX
      ..speedY = -speedY
      ..accelerationX = accelerationX
      ..accelerationY = -accelerationY
      ..hostile = hostile
      ..duration = duration;
    
    if(!hostile && Game.keyboardHandler.isPressingUpKey()) {
      this.speedY -= 500.0;
    }
    if(!hostile && Game.keyboardHandler.isPressingDownKey()) {
      this.speedY += 300.0;
    }

    bitmap
      ..x = x - Game.displayWindow.x
      ..y = y
      ..scaleX = 2.0
      ..scaleY = 2.0;

    this.addChild(bitmap);
    juggler.add(this);
    advanceTime(0.0001);
  }

  num get pivotX{
    return bitmap.pivotX;
  }
  num get pivotY{
    return bitmap.pivotY;
  }

  num get width{
    return bitmap.width;
  }
  num get height{
    return bitmap.height;
  }
  
  bool advanceTime(num time) {
    duration -= time;
    if (duration <= 0) {
      this.dead = true;
    }
    var oldX = x;
    var oldY = y;
    if (bitmap.scaleX < 0.5) {
      bitmap.scaleX += 0.02;
      bitmap.scaleY += 0.02;
    }
    x += speedX * time;
    y += speedY * time;
    
    if (type == 1) {
      y += 5 * random.nextDouble() - 2.5;
    }
    
    
    
    speedX += accelerationX * time;
    speedY += accelerationY * time;
    if (direction != (speedX >= 0 ? 1 : -1)) {
      speedX = 0.0;
    }

    bitmap.rotation = math.atan(speedY / speedX);
    bitmap.x = x - Game.displayWindow.x;
    bitmap.y = y;
    if (dead) {
      return true;
    }
    if (hostile) {
      if (this.collision(Game.player) > 0) {
        Game.player.setDead();
        this.dead = true;
      }
    } else {
      for (Robot robot in Game.robotManager.getAllRobots()) {
        if (this.collision(robot) > 0) {
          robot.setDead();
          this.dead = true;
          print("one robot killed.");
          break;
        }
      }
    } 
    
    if(Collision.isCollidedWithTerrain(this, oldX, oldY) > 0){
      dead = true;
    }
  }

  set dead(bool d){
    dead_= d;
    juggler.remove(this);
  }
  bool get dead{
    return dead_;
  }
  
  bool isDead() {
    return y >= (Statics.WORLD_HEIGHT - Statics.TILE_SIZE) || dead;
  }
}

