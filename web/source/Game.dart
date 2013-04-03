part of contra;

class Game extends Sprite {

  Sprite _gameLayer;
  Sprite _backgroundLayer;
  Sprite _interfaceLayer;

  TextField fpsField;
  double _fpsAverage = null;
  bool started;
  Juggler juggler;

  static Player player;
  static RobotManager robotManager;
  static BulletManager bulletManager;
  static WorldMap worldMap;
  static DisplayWindow displayWindow;
  static KeyboardHandler keyboardHandler;

  Game(Juggler juggler) {
    started = false;
    this.juggler = juggler;

    _backgroundLayer = new Sprite();
    _gameLayer = new Sprite();
    _interfaceLayer = new Sprite();
    // The order of adding does matter!
    addChild(_backgroundLayer);
    addChild(_gameLayer);
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
    print("start");
    if (started) {
      return;
    }
    started = true;

    displayWindow = new DisplayWindow();
    print("displayWindow created");
    worldMap = new WorldMap();
    print("worldMap created.");
    _backgroundLayer.addChild(worldMap);


    player = new Player();
    print("player create");
    _gameLayer.addChild(player);

    juggler.add(player);

    robotManager = new RobotManager(_gameLayer);
    juggler.add(robotManager);
    bulletManager = new BulletManager(_gameLayer);

    keyboardHandler = new KeyboardHandler(player);
    juggler.add(worldMap);
    juggler.add(robotManager);
    juggler.add(bulletManager);
    juggler.add(player);
    juggler.add(keyboardHandler);
  }

  _onEnterFrame(EnterFrameEvent event) {
    if (_fpsAverage == null) {
      _fpsAverage = 1.00 / event.passedTime;
    } else {
      _fpsAverage = 0.05 / event.passedTime + 0.95 * _fpsAverage;
    }
    fpsField.text = 'fps: ${_fpsAverage.round()}';
  }

}
