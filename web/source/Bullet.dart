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
    bitmap
      ..x = x - Game.displayWindow.x
      ..y = y
      ..scaleX = 0.15
      ..scaleY = 0.15;
    
    this
      ..x = x - (speedX >= 0 ? 0 : bitmap.width)
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


    this.addChild(bitmap);
    juggler.add(this);
  }

  Bullet.gun(double x, double y,
         double speedX, double speedY,
         double accelerationX, accelerationY,
         bool hostile, num duration) {
    type = 1;//gun
    this.direction = speedX >= 0 ? 1 : -1;
    if(hostile) {
      bitmap = new Bitmap(Grafix.resourceManager.getBitmapData("bullet2"));
    }
    else {
      bitmap = new Bitmap(Grafix.resourceManager.getBitmapData(direction == 1 ? "bullet1Right" : "bullet1Left"));
    }
    bitmap
      ..x = x - Game.displayWindow.x
      ..y = y
      ..scaleX = 2.0
      ..scaleY = 2.0;
    if(hostile){
      bitmap.scaleX = 1.0;
      bitmap.scaleY = 1.0;
    }
    this
      ..x = x - (speedX >= 0 ? 0 : bitmap.width)
      ..y = y
      ..speedX = speedX
      ..speedY = -speedY
      ..accelerationX = accelerationX
      ..accelerationY = -accelerationY
      ..hostile = hostile
      ..duration = duration;
    
    if(!hostile && Game.keyboardHandler.isPressingUpKey()) {
      this.speedY -= 500.0;
      if (this.speedX < 0) {
        var theta = math.atan(this.speedY / this.speedX);
        this.y -= bitmap.width * math.sin(theta);
        var l = bitmap.width * math.tan(theta);
        this.x += l * math.sin(theta) / 2;
      }
    }
    if(!hostile && Game.keyboardHandler.isPressingDownKey()) {
      this.speedY += 300.0;
      if (this.speedX < 0) {
        this.y -= bitmap.width * math.sin(math.atan(this.speedY / this.speedX));
      }
    }

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
    if(type == 1 && !hostile){
      return 10;
    } else {
      return bitmap.width;
    }
  }
  num get height{
    if(type == 1 && !hostile){
      return 10;
    } else {
      return bitmap.height;
    }
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
    
    if (type == 1 && !hostile) {
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
        Game.player.hurt(10);
        this.dead = true;
      }
    } else {
      for (Robot robot in Game.robotManager.getAllRobots()) {
        if (this.collision(robot) > 0) {
          robot.hurt();
          if(this.type != 0)
          this.dead = true;
          print("one robot killed.");
          break;
        }
      }
      
      for (Bird bird in Game.birdManager.getAllBirds()) {
        if (this.collision(bird) > 0) {
          bird.setDead();
          this.dead = true;
          print("one robot killed.");
          break;
        }
      }
      
      //also if it is a bomb, we can kill enemy's bullets as well
      if (type == 0) {
        for(Bullet b in Game.bulletManager.bullets){
           if(b.hostile && b.collision(this) > 0){
              b.dead = true; 
           }
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

