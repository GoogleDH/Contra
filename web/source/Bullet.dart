part of contra;

class Bullet extends Object implements Animatable {
  double speedX;
  double speedY;
  double accelerationX;
  double accelerationY;

  bool dead_ = false;

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
      ..duration = duration;
    
    if(!hostile && Game.keyboardHandler.isPressingUpKey()) {
      this.speedY -= 500;
    }

    bitmap
      ..x = x - Game.displayWindow.x
      ..y = y
      ..scaleX = 0.15
      ..scaleY = 0.15;

    this.addChild(bitmap);
    juggler.add(this);
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
    if (bitmap.scaleX < 0.5) {
      bitmap.scaleX += 0.02;
      bitmap.scaleY += 0.02;
    }
    x += speedX * time;
    y += speedY * time;
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
    
    if(Collision.isCollidedWithTerrain(this) > 0){
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

