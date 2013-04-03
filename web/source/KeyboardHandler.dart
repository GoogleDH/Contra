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
      if (keyCodes.isEmpty) {
        switch (e.keyCode) {
          case Statics.KEY_LEFT:
          case Statics.KEY_RIGHT:
          case Statics.KEY_DOWN:
          case Statics.KEY_JUMP:
            player.onStand();
            break;
        }
      }
    });
    
  }
  
  bool advanceTime(num time) {
    for (var code in keyCodes) {
      switch (code) {
        case Statics.KEY_FIRE:  player.onFire();   break;
        case Statics.KEY_RIGHT: player.onRight();  break;
        case Statics.KEY_LEFT:  player.onLeft();   break;
        case Statics.KEY_DOWN:  player.onCrouch(); break;
        case Statics.KEY_JUMP:  player.onJump();   break;
      }
    }
  }

  bool isPressingUpKey() {
    return keyCodes.contains(Statics.KEY_UP);
  }
}