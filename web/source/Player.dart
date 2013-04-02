part of contra;

class Player extends Object implements Animatable {
  
  player() {
    
  }
  
  bool advanceTime(num time) {
    // update player state and animation, x,y
  }
  
  onLeft() {
    
  }
  
  onRight() {
    
  }
  
  onJump() {
    
  }
  
  onCrouch() {
    
  }
  
  onShoot() {
    
  }
  
  onFire() {
    Game.bulletManager.playerFired(this);
  }
}

