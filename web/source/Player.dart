part of contra;

class Player extends Object implements Animatable {

  Animation left_stand;
  Animation right_stand;
  Animation left_run;
  Animation right_run;
  Animation left_crouch;
  Animation right_crouch;
  Animation dead;

  Animation current;

  int state;
  bool isDead = false;
  
  Player() {
    // Generate Animations
    left_stand = new Animation(this);
    right_stand = new Animation(this);
    left_run = new Animation(this);
    right_run = new Animation(this);
    left_crouch = new Animation(this);
    right_crouch = new Animation(this);
    dead = new Animation(this);

    left_stand.addFrame(new AnimationFrame("player_leftstand", Animation.FOREVER));
    right_stand.addFrame(new AnimationFrame("player_rightstand", Animation.FOREVER));
    left_run.addFrame(new AnimationFrame("player_leftrun1", 0.1));
    left_run.addFrame(new AnimationFrame("player_leftrun2", 0.1));
    left_run.addFrame(new AnimationFrame("player_leftrun3", 0.1));
    left_run.addFrame(new AnimationFrame("player_leftrun2", 0.1));
    right_run.addFrame(new AnimationFrame("player_rightrun1", Animation.FOREVER)); // TODO
    left_crouch.addFrame(new AnimationFrame("player_leftcrouch", Animation.FOREVER));
    right_crouch.addFrame(new AnimationFrame("player_rightcrouch", Animation.FOREVER));
    dead.addFrame(new AnimationFrame("player_dead", Animation.FOREVER));
    
    setCurrentAnimation(right_stand);
    
    x = current.getBitmap().x = 100.0;
    y = current.getBitmap().y = 0.0;
  
    speedX = 0.0;
    speedY = 0.0;

    direction = Statics.DIRECTION_RIGHT;
    state = Statics.PLAYER_STATE_STAND;
  }

  setCurrentAnimation(Animation animation) {
    if (current == animation) {
      return;
    }
    if (current != null) {
      current.stop();
    }
    current = animation;
    width = current.getBitmap().width;
    height = current.getBitmap().height;
    if (x != null) {
      current.getBitmap().x = x;
    }
    if (y != null) {
      y = math.min(y, WorldMap.fixedLeastHeight - height);
      current.getBitmap().y = y;
    }
    current.start();
  }

  bool advanceTime(num time) {
    // update player state and animation, x,y
    var oldX = x;
    var oldY = y;
    // update x
    if (state == Statics.PLAYER_STATE_MOVE) {
      x += speedX * time;;
      if (x < 0) {
        x = 0.0;
      }
      if (x > Game.worldMap.width - width) {
        x = Game.worldMap.width - width;
      }
    }

    // udpate y
    speedY += Statics.SPEED_Y_ACCELERATE;
    Tile somethingToStandOn = Collision.hasSomethingToStandOn(this);
    if(somethingToStandOn == null ) {
      // we are in the air, update Y according to speedY
      y += speedY;
      if(y > WorldMap.fixedLeastHeight - height){
        speedY = 0.0;
        y = WorldMap.fixedLeastHeight - height;
      }
    } else {
      if(speedY >= 0){ 
        // falling
        speedY = 0.0;
        y = somethingToStandOn.y - height;
      } else {
        // ascending
        print("Branch 3");
        y += speedY;
      }
    } 
    
    int collision = Collision.isCollidedWithTerrain(this);
    if(collision == 1 || collision == 3){
      //collided on x, reset x
      x = oldX;
    }
    if(collision >= 2){
      // prevent from going into wall, in x and y direction
      if(oldY < y){
        speedY = 0.0;
      }
      y = oldY;
    }
    
    current.getBitmap().x = x - Game.displayWindow.x;
    current.getBitmap().y = y;

    Game.displayWindow.updateAbosultePos(this);
  }

  onLeft() {
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
    speedX = 0.0;
    if (direction == Statics.DIRECTION_LEFT) {
      setCurrentAnimation(left_stand);
    } else {
      setCurrentAnimation(right_stand);
    }
    state = Statics.PLAYER_STATE_STAND;
  }

  onCrouch() {
    if (direction == Statics.DIRECTION_LEFT) {
      setCurrentAnimation(left_crouch);
    } else {
      setCurrentAnimation(right_crouch);
    }
    state = Statics.PLAYER_STATE_CROUCH;
  }

  onFire() {
    Game.bulletManager.playerFired(this);
  }

  setDead() {
    isDead = true;
    state = Statics.PLAYER_STATE_DEAD;
    setCurrentAnimation(dead);
  }
  
  String toString(){
    return "Player: "+super.toString();
  }
}

