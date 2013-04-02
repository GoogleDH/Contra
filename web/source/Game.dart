part of contra;

class Game extends Sprite {
  
  Sprite _gameLayer;
  Sprite _backgroundLayer;
  Sprite _interfaceLayer;
  
  TextField fpsField;
  double _fpsAverage = null;
  bool started;
  
  static Player player;
  static RobotManager robotManager;
  static BulletManager bulletManager;
  
  HashSet<int> keyCodes;
  DateTime lastEventFired;
  int eventInterval = 16;
  Game() {
    started = false;
    _gameLayer = new Sprite();
    _backgroundLayer = new Sprite();
    _interfaceLayer = new Sprite();
    addChild(_gameLayer);
    addChild(_backgroundLayer);
    addChild(_interfaceLayer);
      
    // fps
    fpsField = new TextField();
    fpsField.defaultTextFormat = new TextFormat('Helvetica,Arial', 16, Color.Black);
    fpsField.x = 10;
    fpsField.y = 10;
    _interfaceLayer.addChild(fpsField);
    fpsField.onEnterFrame.listen(_onEnterFrame);
    
  }
  
  start() {
    if (started) {
      return;
    }
    started = true;
    player = new Player();
    robotManager = new RobotManager();
    bulletManager = new BulletManager();
    //let bulletManager has reference to game layer
    bulletManager.layer = _gameLayer;
    _gameLayer.addChild(player);
    lastEventFired = new DateTime.now();    
    keyCodes = new HashSet<int>();
    html.window.onKeyUp.listen((e){
      keyCodes.remove(e.keyCode);
    });
    html.window.onKeyDown.listen((e){
      keyCodes.add(e.keyCode);
//
    });
    
  }
  
  _dispatchKey() {
    print(keyCodes);
    for(int e in keyCodes){
      if (e == 1) {
        player.onLeft();
      } else if (e == 2) {
        player.onRight();
      } else if (e == 3) {
        player.onJump();
      } else if (e == 4) {
        player.onShoot();
      } else if (e == 5) {
        player.onCrouch();
      } else if (e == 32) {
        print("Fire!");
        player.onFire();
      }  
    }
  }
  
  _onEnterFrame(EnterFrameEvent event) {
    if (_fpsAverage == null) {
      _fpsAverage = 1.00 / event.passedTime;
    } else {
      _fpsAverage = 0.05 / event.passedTime + 0.95 * _fpsAverage;
    }
    fpsField.text = 'fps: ${_fpsAverage.round()}';
    
    var now = new DateTime.now();
    if((now.millisecondsSinceEpoch - lastEventFired.millisecondsSinceEpoch) > eventInterval) {
      lastEventFired = now;
      _dispatchKey();
    }
    
  }
}
