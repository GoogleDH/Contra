part of contra;

class KeyboardHandler implements Animatable {
  HashSet<int> keyCodes = new HashSet<int>();
  Player player;
  
  KeyboardHandler(Player player) {
    this.player = player;
    
    html.window.onKeyDown.listen((e) {
      keyCodes.add(e.keyCode);
    });
    
    html.window.onKeyUp.listen((e) {
      keyCodes.remove(e.keyCode);
      switch (e.keyCode) {
        case Statics.KEY_LEFT:
        case Statics.KEY_RIGHT:
        case Statics.KEY_DOWN:
        case Statics.KEY_JUMP:
          if (keyCodes.contains(Statics.KEY_LEFT)
           || keyCodes.contains(Statics.KEY_RIGHT)
           //|| keyCodes.contains(Statics.KEY_DOWN)
           || keyCodes.contains(Statics.KEY_JUMP)) {
            break;
          }
          player.onStand();
          break;
      }
    });
    
  }
  
  bool advanceTime(num time) {
    for (var code in keyCodes) {
      switch (code) {
        case Statics.KEY_FIRE:  player.onFire();   break;
        case Statics.KEY_BOMB:  player.onBomb();   break;
        case Statics.KEY_LEFT:
        case Statics.KEY_RIGHT: 
          if(keyCodes.contains(Statics.KEY_LEFT) && keyCodes.contains(Statics.KEY_RIGHT)){
            break;
          }
          if (code == Statics.KEY_LEFT) {
            player.onLeft();
          } else {
            player.onRight();  
          }
          break;
        case Statics.KEY_DOWN:  player.onCrouch(); break;
        case Statics.KEY_JUMP:  player.onJump();   break;
      }
    }
  }

  bool isPressingUpKey() {
    return keyCodes.contains(Statics.KEY_UP);
  }
  bool isPressingDownKey() {
    return keyCodes.contains(Statics.KEY_DOWN);
  }
}