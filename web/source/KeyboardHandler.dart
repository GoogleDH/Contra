part of contra;

class KeyboardHandler implements Animatable {
  HashSet<int> keyCodes;
  Player player;
  
  KeyboardHandler(Player player) {
    this
      ..player = player
      ..keyCodes = new HashSet<int>();
    html.window.onKeyDown.listen((e) {
      keyCodes.add(e.keyCode);
    });
    html.window.onKeyUp.listen((e) {
      keyCodes.remove(e.keyCode);
    });
  }
  
  bool advanceTime(num time) {
    //if (!keyCodes.isEmpty) print(keyCodes);
    player.onStand();
    for (var code in keyCodes) {
      switch (code) {
        case Statics.KEY_FIRE:  player.onFire();   break;
        case Statics.KEY_RIGHT: player.onRight();  break;
        case Statics.KEY_LEFT:  player.onLeft();   break;
        case Statics.KEY_DOWN:  player.onCrouch(); break;
        case Statics.KEY_JUMP:  player.onJump();   break;
        case Statics.KEY_CREATE_ENEMY:  Game.robotManager.createNewRobot();   break;
      }
    }
  }
  
  bool isPressingUpKey(){
    return keyCodes.contains(Statics.KEY_UP);
  }
  
}