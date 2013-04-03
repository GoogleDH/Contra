part of contra;

class Player extends Object implements Animatable {
  
  BitmapData playerData = new BitmapData(40, 80, false, Color.Red);
  BitmapData crouchData = new BitmapData(80, 40, false, Color.Red);
  
  int directDegree;
  Bitmap playerBitmap;
  int state;
  bool isDead = false;
  
  Player() {
    
    playerBitmap = new Bitmap(playerData);
    playerBitmap.x = x = 100.0;
    playerBitmap.y = y = WorldMap.fixedLeastHeight - 
                              playerBitmap.height;
    print("${x} ${y}");
    speedX = 0.0;
    speedY = 0.0;
    state = Statics.PLAYER_STATE_STAND;
    addChild(playerBitmap);
  }
  
  bool advanceTime(num time) {
    // update player state and animation, x,y
    
    bool changed = false;
    // update x
    if (state == Statics.PLAYER_STATE_MOVE) {
      x += speedX * time;
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
    
    if (changed) {
      playerBitmap.x = (x - Game.displayWindow.x).toInt();
      playerBitmap.y = y.toInt();
    }
    
    Game.displayWindow.updateAbosultePos(this);
  }
  
  onLeft() {
    speedX = -Statics.SPEED_X;
    state = Statics.PLAYER_STATE_MOVE;
  }
  
  onRight() {
    speedX = Statics.SPEED_X;
    state = Statics.PLAYER_STATE_MOVE;
  }
  
  onJump() {
    if (this.speedY != 0) {
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
  }

  onFire() {
    Game.bulletManager.playerFired(this);
  }
  
  setDead() {
    isDead = true;
  }
}

