part of contra;

class Robot extends Object implements Animatable {
  
  Animation left_run;
  Animation right_run;
  
  Animation current;
  
  double speedX;
  double speedY;
  bool isDead = false;
  
  double max_width = 0.0;
  double max_height = 0.0;

  Robot(double x, double y) {
    left_run = new Animation(this);
    right_run = new Animation(this);
    
    left_run.addFrame(new AnimationFrame("robot_leftmove1", 0.2));
    left_run.addFrame(new AnimationFrame("robot_leftmove2", 0.2));
    left_run.addFrame(new AnimationFrame("robot_leftmove3", 0.2));
    left_run.addFrame(new AnimationFrame("robot_leftmove2", 0.2));
    
    right_run.addFrame(new AnimationFrame("robot_rightmove1", 0.2));
    right_run.addFrame(new AnimationFrame("robot_rightmove2", 0.2));
    right_run.addFrame(new AnimationFrame("robot_rightmove3", 0.2));
    right_run.addFrame(new AnimationFrame("robot_rightmove2", 0.2));
    
    var animations = [left_run, right_run];
    
    for (var x in animations) {
      for (var f in x.frames) {
        max_width = math.max(max_width, f.bitmap.width);
        max_height = math.max(max_height, f.bitmap.height);
      }
    }
    
    
    
    this
      ..x = x
      ..y = y
      ..speedX = 50.0
      ..speedY = 0.0;
    setCurrentAnimation(right_run);
    juggler.add(this);
  }
  
  double get height => max_height;
  double get width => max_width;
  
  void setCurrentAnimation(Animation animation) {
    if (current == animation) {
      return;
    }
    if (current != null) {
      current.stop();
    }
    current = animation;
    current.start();
    if (x != null) {
      current.getBitmap().x = x - Game.displayWindow.x;
    }
    if (y != null) {
      y = math.min(y, WorldMap.fixedLeastHeight - height);
      current.getBitmap().y = y;
    }
    
  }

  destroy() {
    juggler.remove(this); 
  }

  double shouldTurnAround = 0.0;

  bool advanceTime(num time) {
    var oldX = x;
    var oldY = y;
    
    
    //x += speedX * time;
    //y += speedY * time;
    //speedX += accelerationX * time;
    //speedY += accelerationY * time;

    //current.getBitmap().x = x - Game.displayWindow.x;
    current.update(time);
/*
    if(random.nextDouble() > 0.97) {
      Game.bulletManager.robotFired(this);
      Sounds.playSoundEffect("robot_fire");
    }
*/
    Tile somethingToStandOn = Collision.hasSomethingToStandOn(this);
    
    // update x
    if (true) {
      x += speedX * time;;
      if (x < 0) {
        x = 0.0;
      }
      if (x > Game.worldMap.width - this.width) {
        x = Game.worldMap.width - this.width;
      }
    }

    // udpate y
    if (somethingToStandOn == null) {
      // we are in the air, update Y according to speedY
      speedY += Statics.SPEED_Y_ACCELERATE;
      y += speedY;
      if(y > WorldMap.fixedLeastHeight - height){
        speedY = 0.0;
        y = WorldMap.fixedLeastHeight - height;
      }
    } else {
      if(speedY > 0){ 
        // falling
        speedY = 0.0;
        y = somethingToStandOn.y - height;
      } else if(speedY < 0){
        // ascending
        y += speedY;
      } else {
        // standing
        // do nothing?
      }
    } 
    
    int collision = Collision.isCollidedWithTerrain(this, oldX, oldY);
    if(collision == 1 || collision == 3){
      //collided on x, reset x
      x = oldX;
      speedX = -speedX;
      if (speedX > 0) {
        setCurrentAnimation(right_run);
      } else {
        setCurrentAnimation(left_run);
      }
      
    }
    if(collision >= 2){
      // prevent from going into wall, in x and y direction
      speedY = 0.0;
      y = oldY;
    }

    current.getBitmap().x = x - Game.displayWindow.x;
    current.getBitmap().y = y;

  }

  setDead() {
    this.isDead = true;
    Sounds.playSoundEffect("robot_dead");
  }
}

