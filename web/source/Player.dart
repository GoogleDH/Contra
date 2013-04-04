part of contra;

class Player extends Object implements Animatable {

  Animation left_stand;
  Animation right_stand;
  Animation left_crouch;
  Animation right_crouch;
  Animation left_run;
  Animation right_run;
  Animation left_die;
  Animation right_die;
  Animation left_jump;
  Animation right_jump;

  Animation current;
  
  int hp = 100;
  
  static const FULL_HP = 100;
  
  static const double borderX = 20.0;
  static const double borderY = 0.0;

  int state;
  bool isDead = false;
  
  double max_width = 0.0;
  double max_height = 0.0;
  
  Player() {
    // Generate Animations
    left_stand = new Animation(this);
    right_stand = new Animation(this);
    left_crouch = new Animation(this);
    right_crouch = new Animation(this);
    left_run = new Animation(this);
    right_run = new Animation(this);
    left_die = new Animation(this);
    right_die = new Animation(this);
    left_jump = new Animation(this);
    right_jump = new Animation(this);
    
    print("here");
    left_stand.addFrame(new AnimationFrame("player_leftstand", Animation.FOREVER));
    right_stand.addFrame(new AnimationFrame("player_rightstand", Animation.FOREVER));
    left_crouch.addFrame(new AnimationFrame("player_leftcrouch", Animation.FOREVER));
    right_crouch.addFrame(new AnimationFrame("player_rightcrouch", Animation.FOREVER));
    left_run.addFrame(new AnimationFrame("player_leftrun1", 0.2));
    left_run.addFrame(new AnimationFrame("player_leftrun2", 0.2));
    left_run.addFrame(new AnimationFrame("player_leftrun3", 0.2));
    left_run.addFrame(new AnimationFrame("player_leftrun2", 0.2));
    right_run.addFrame(new AnimationFrame("player_rightrun1", 0.2));
    right_run.addFrame(new AnimationFrame("player_rightrun2", 0.2));
    right_run.addFrame(new AnimationFrame("player_rightrun3", 0.2));
    right_run.addFrame(new AnimationFrame("player_rightrun2", 0.2));
    left_die.addFrame(new AnimationFrame("player_leftdie", Animation.FOREVER));
    right_die.addFrame(new AnimationFrame("player_rightdie", Animation.FOREVER));
    left_jump.addFrame(new AnimationFrame("player_leftjump", Animation.FOREVER));
    right_jump.addFrame(new AnimationFrame("player_rightjump", Animation.FOREVER));
    
    List<Animation> animations = [left_stand, right_stand, left_crouch, right_crouch,
                                  left_run, right_run, left_die, right_die, left_jump,
                                  right_jump];
    
    for (var x in animations) {
      for (var f in x.frames) {
        max_width = math.max(max_width, f.bitmap.width);
        max_height = math.max(max_height, f.bitmap.height);
      }
    }
    
    setCurrentAnimation(right_stand);
    
    x = 100.0;
    y = 0.0;
    current.getBitmap().x = x - borderX;
    current.getBitmap().y = y - borderY * 2;
  
    speedX = 0.0;
    speedY = 0.0;

    direction = Statics.DIRECTION_RIGHT;
    state = Statics.PLAYER_STATE_STAND;
  }
  
  double get width {
    return max_width - borderX * 2;
  }
  
  double get height {
    return max_height - borderY * 2;
  }

  setCurrentAnimation(Animation animation) {
    if (current == animation) {
      return;
    }
    if (current != null) {
      current.stop();
    }
    current = animation;
    current.start();
    if (x != null) {
      current.getBitmap().x = x - Game.displayWindow.x - borderX;
    }
    if (y != null) {
      y = math.min(y, WorldMap.fixedLeastHeight - height);
      current.getBitmap().y = y - borderY * 2;
    }
    
  }

  bool advanceTime(num time) {
    // update player state and animation, x,y
    var oldX = x;
    var oldY = y;
    
    current.update(time);
    Tile somethingToStandOn = Collision.hasSomethingToStandOn(this);
    
    // update x
    if (state == Statics.PLAYER_STATE_MOVE) {
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
    var deltaX = x - oldX;
    var deltaY = y - oldY;
    int attempt = 3;
    while(attempt -- >= 0) {
      
      int collision = Collision.isCollidedWithTerrain(this, oldX, oldY);
      if(collision == 1 || collision == 3){
        //collided on x, reset x
        x -= deltaX;
        oldX -= deltaX;
      }
      if(collision >= 2){
        // prevent from going into wall, in x and y direction
        speedY = 0.0;
        y -= deltaY;
        oldY -= deltaY;
      }
      if(collision == 0)
        break;
//      print("Backward");
    }
    
    for (Robot robot in Game.robotManager.getAllRobots()) {
      if (this.collision(robot) > 0) {
        hurt(1);
        break;
      }
    }

    current.getBitmap().x = x - Game.displayWindow.x - borderX;
    current.getBitmap().y = y - borderY * 2;

    Game.displayWindow.updateAbosultePos(this);
    
    
    //check if we reached destination point
    if(Collision.reachedEnd(this)){
      Game.hudManager.showEnd(true);
      juggler.purge();
    }
    
  }

  onLeft() {
    if (state == Statics.PLAYER_STATE_DEAD) {
      return;
    }
    direction = Statics.DIRECTION_LEFT;
    if (state == Statics.PLAYER_STATE_CROUCH) {
      return;
    }
    if(speedX >= 0) {
      speedX = -Statics.SPEED_X;
    } else {
      speedX -= Statics.SPEED_X_ACCELERATE;
      if(speedX < -Statics.SPEED_X_MAX)
        speedX = -Statics.SPEED_X_MAX;
    }
    
    state = Statics.PLAYER_STATE_MOVE;
    setCurrentAnimation(left_run);
  }

  onRight() {
    if (state == Statics.PLAYER_STATE_DEAD) {
      return;
    }
    direction = Statics.DIRECTION_RIGHT;
    if (state == Statics.PLAYER_STATE_CROUCH) {
      return;
    }
    if(speedX <= 0) {
      speedX = Statics.SPEED_X;
    } else {
      speedX += Statics.SPEED_X_ACCELERATE;
      if(speedX > Statics.SPEED_X_MAX)
        speedX = Statics.SPEED_X_MAX;
    }
    state = Statics.PLAYER_STATE_MOVE;
    setCurrentAnimation(right_run);
  }

  onJump() {
    if (state == Statics.PLAYER_STATE_DEAD) {
      return;
    }
    
    Tile s = Collision.hasSomethingToStandOn(this);
    if (s == null || state == Statics.PLAYER_STATE_CROUCH) {
      return;
    }
    var sX = speedX == 0 ? Statics.SPEED_X :( speedX > 0 ? speedX : -speedX);
    speedY = Statics.SPEED_Y_INITIAL - (sX - 280) * .029411765;
    //speedY = Statics.SPEED_Y_INITIAL;
    print("speedY : $speedY");
    if (state != Statics.PLAYER_STATE_MOVE) {
      state = Statics.PLAYER_STATE_JUMP;
    }
  }

  onStand() {
    if (state == Statics.PLAYER_STATE_DEAD) {
      return;
    }
    speedX = 0.0;
    if (direction == Statics.DIRECTION_LEFT) {
      setCurrentAnimation(left_stand);
    } else {
      setCurrentAnimation(right_stand);
    }
    state = Statics.PLAYER_STATE_STAND;
    Sounds.playSoundEffect("clip_change");
  }

  onCrouch() {
    /*
    if (state == Statics.PLAYER_STATE_DEAD) {
      return;
    }
    if (direction == Statics.DIRECTION_LEFT) {
      setCurrentAnimation(left_crouch);
    } else {
      setCurrentAnimation(right_crouch);
    }
    state = Statics.PLAYER_STATE_CROUCH;
    */
  }
  
  onFire() {
    if (state == Statics.PLAYER_STATE_DEAD) {
      return;
    }
    Game.bulletManager.playerFired(this);
    Sounds.playSoundEffect("rifle");
  }

  onBomb() {
    if (state == Statics.PLAYER_STATE_DEAD) {
      return;
    }
    Game.bulletManager.playerBombed(this);
  }
  
  hurt(int v) {
    if (isDead) {
      return;
    }
    hp-=v;
    if (hp <= 0) {
      setDead();
    }
    Game.hudManager.updateBloodStrip(this);
  }

  setDead() {
    Game.hudManager.showEnd(false);
    state = Statics.PLAYER_STATE_DEAD;
    if (direction == Statics.DIRECTION_LEFT) {
      setCurrentAnimation(left_die);
    } else {
      setCurrentAnimation(right_die);
    }
    isDead = true;
    Sounds.playSoundEffect("player_dead");
  }
  
  String toString(){
    return "Player: "+super.toString();
  }
}

