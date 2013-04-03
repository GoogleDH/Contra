part of contra;

class Bullet extends Object implements Animatable {
  double speedX;
  double speedY;
  double accelerationX;
  double accelerationY;
  bool dead = false;
  
  int direction;
  bool hostile; // hostile to player or not
  int duration; // seconds before it kills itself
  
  Bitmap bitmap;
  
  Bullet(double x, double y,
         double speedX, double speedY,
         double accelerationX, accelerationY,
         bool hostile, int duration) {
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
      ..duration = duration
      ..width = bitmap.width
      ..height = bitmap.height;
    
    if(!hostile && Game.keyboardHandler.isPressingUpKey()) {
      this.speedY -= 500;
    }
    
    
    bitmap
      ..x = x - Game.displayWindow.x
      ..y = y
      ..pivotX = bitmap.width / 2
      ..pivotY = bitmap.height / 2
      ..scaleX = 0.5
      ..scaleY = 0.5;
    
    this.addChild(bitmap);
    juggler.add(this);
  }
  
  bool advanceTime(num time) {
    x += speedX * time;
    y += speedY * time;
    speedX += accelerationX * time;
    speedY += accelerationY * time;
    if (direction != (speedX >= 0 ? 1 : -1))
      speedX = 0.0;
    
    bitmap.rotation = math.atan(speedY / speedX);
    bitmap.x = x - Game.displayWindow.x;
    bitmap.y = y;
    if (dead) {
      return true;
    }
    if (hostile) {
      if (this.collision(Game.player)) {
        Game.player.setDead();
        this.dead = true;
      }
    } else {
      for (Robot robot in Game.robotManager.getAllRobots()) {
        if (this.collision(robot)) {
          robot.setDead();
          this.dead = true;
          print("one robot killed.");
          break;
        }
      }
    }
  }
  
  bool isDead() {
    return y >= (Statics.WORLD_HEIGHT - Statics.TILE_SIZE) || dead;
  }
}

