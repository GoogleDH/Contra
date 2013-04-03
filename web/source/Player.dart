part of contra;

class Player extends Object implements Animatable {
  
  Animation left_stand;
  Animation right_stand;
  Animation left_crouch;
  Animation right_crouch;
  Animation dead;
  
  Animation current;
  
  BitmapData playerData = new BitmapData(40, 80, false, Color.Red);
  BitmapData crouchData = new BitmapData(80, 40, false, Color.Red);
  
  int directDegree;
  Bitmap playerBitmap;
  int state;
  bool isDead = false;
  
  Player() {
    
    playerBitmap = new Bitmap(playerData);
    playerBitmap.x = x = 100.0;
    playerBitmap.y = y = WorldMap.fixedLeastHeight - playerBitmap.height;
    print("${x} ${y}");
    speedX = 0.0;
    speedY = 0.0;
    this.height = playerBitmap.height;
    this.width = playerBitmap.width;
    direction = Statics.DIRECTION_RIGHT;
    
    state = Statics.PLAYER_STATE_STAND;
    addChild(playerBitmap);
    
    // Generate Animations
    left_stand = new Animation(this);
    right_stand = new Animation(this);
    left_crouch = new Animation(this);
    right_crouch = new Animation(this);
    dead = new Animation(this);
    
    left_stand.addFrame(new AnimationFrame("player_leftstand", Animation.FOREVER));
    right_stand.addFrame(new AnimationFrame("player_rightstand", Animation.FOREVER));
    left_crouch.addFrame(new AnimationFrame("player_leftcrouch", Animation.FOREVER));
    right_crouch.addFrame(new AnimationFrame("player_rightcrouch", Animation.FOREVER));
    dead.addFrame(new AnimationFrame("player_dead", Animation.FOREVER));
  }
  
  setCurrentAnimation(Animation animation) {
    if (current != null) {
      current.stop();
    }
    current = animation;
    width = current.getBitmap().width;
    height = current.getBitmap().height;
    current.getBitmap().x = x;
    current.getBitmap().y = y;
    current.start();
  }
  
  bool advanceTime(num time) {
    // update player state and animation, x,y
    
    bool changed = false;
    // update x
    if (state == Statics.PLAYER_STATE_MOVE) {
      x += speedX * time;
      if (x < 0) {
        x = 0.0;
      }
      if (x > Game.worldMap.width - this.width) {
        x = Game.worldMap.width - this.width;
      }
      changed = true;
    }
    
    // udpate y
    if (y < WorldMap.fixedLeastHeight - playerBitmap.height ||
        speedY == Statics.SPEED_Y_INITIAL) {
      y += speedY * time;
      changed = true;
      speedY += Statics.SPEED_Y_ACCELERATE;
      if (y >= WorldMap.fixedLeastHeight - playerBitmap.height) {
        y = WorldMap.fixedLeastHeight - playerBitmap.height;
        speedY = 0.0;
        if (state == Statics.PLAYER_STATE_JUMP) {
          onStand();
        }
      }
    }
    
    Game.displayWindow.updateAbosultePos(this);
    
    if (changed) {
      playerBitmap.x = (x - Game.displayWindow.x).toInt();
      
      playerBitmap.y = y.toInt();
    }
    
   
  }
  
  onLeft() {
    if (state == Statics.PLAYER_STATE_CROUCH) {
      return;
    }
    speedX = -Statics.SPEED_X;
    state = Statics.PLAYER_STATE_MOVE;
    direction = Statics.DIRECTION_LEFT;
  }
  
  onRight() {
    if (state == Statics.PLAYER_STATE_CROUCH) {
      return;
    }
    speedX = Statics.SPEED_X;
    state = Statics.PLAYER_STATE_MOVE;
    direction = Statics.DIRECTION_RIGHT;
  }
  
  onJump() {
    if (this.speedY != 0 || state == Statics.PLAYER_STATE_CROUCH) {
      return;
    }
    speedY = Statics.SPEED_Y_INITIAL;
    
    if (state != Statics.PLAYER_STATE_MOVE) {
      state = Statics.PLAYER_STATE_JUMP;
    }
  }
  
  onStand() {
    speedX = 0.0;
    playerBitmap.bitmapData = playerData;
    state = Statics.PLAYER_STATE_STAND;
  }
  
  onCrouch() {
    playerBitmap.bitmapData = crouchData;
    state = Statics.PLAYER_STATE_CROUCH;
  }

  onFire() {
    Game.bulletManager.playerFired(this);
  }
  
  setDead() {
    isDead = true;
  }
}

