part of contra;

class KeyboardHandler {
  // HashSet<int> keyCodes;
  Player player;
  
  KeyboardHandler(Player player) {
    this.player = player;
     // ..keyCodes = new HashSet<int>();
    html.window.onKeyDown.listen((e) {
      switch(e.keyCode) {
        case Statics.KEY_FIRE: player.onFire(); break;
        case Statics.KEY_RIGHT: player.onRight(); break;
        case Statics.KEY_LEFT: player.onLeft(); break;
        case Statics.KEY_DOWN: player.onCrouch(); break;
        case Statics.KEY_JUMP: player.onJump(); break;
        case Statics.KEY_CREATE_ENEMY:  Game.robotManager.createNewRobot(); break;
      }
    });
    html.window.onKeyUp.listen((e) {
      switch(e.keyCode) {
        case Statics.KEY_LEFT:
        case Statics.KEY_RIGHT:
        case Statics.KEY_DOWN:
          player.onStand(); break;
      }
    });
  }

  bool isPressingUpKey(){
    return false;
    // return keyCodes.contains(Statics.KEY_UP);
  }
}