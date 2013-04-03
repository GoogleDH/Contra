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
    
    
    setCurrentAnimation(right_run);
    
    this
      ..x = x
      ..y = y
      ..speedX = 100.0
      ..speedY = 0.0;
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
    x += speedX * time;
    y += speedY * time;
    //speedX += accelerationX * time;
    //speedY += accelerationY * time;

    current.getBitmap().x = x - Game.displayWindow.x;
    current.update(time);
/*
    if(random.nextDouble() > 0.97) {
      Game.bulletManager.robotFired(this);
    }
*/
    
  }

  setDead() {
    this.isDead = true;
  }
}

