part of contra;

class Game extends Sprite {

  Sprite _gameLayer;
  Sprite _backgroundLayer;
  Sprite _interfaceLayer;

  TextField fpsField;
  double _fpsAverage = null;
  bool started;
  Juggler juggler;
  Stage stage;

  static Player player;
  static RobotManager robotManager;
  static BulletManager bulletManager;
  static WorldMap worldMap;
  static DisplayWindow displayWindow;
  static KeyboardHandler keyboardHandler;
  static TouchManager touchManager;

  Game(Stage stage, Juggler juggler) {
    started = false;
    this.juggler = juggler;
    this.stage = stage;

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
    bulletManager = new BulletManager(_gameLayer);
    keyboardHandler = new KeyboardHandler(player);
    touchManager = new TouchManager();
    
    juggler.add(robotManager);
    juggler.add(worldMap);
    juggler.add(robotManager);
    juggler.add(bulletManager);
    juggler.add(player);
    juggler.add(keyboardHandler);
    if (Multitouch.supportsTouchEvents) {
      print("Oh touch screen is supported.");
      Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
      GlassPlate glass = new GlassPlate(Statics.BACKGROUND_WIDTH, Statics.BACKGROUND_HEIGHT);
      glass.addTo(stage);
      glass.addEventListener(TouchEvent.TOUCH_BEGIN, touchManager.onTouchBegin);
      glass.addEventListener(TouchEvent.TOUCH_END, touchManager.onTouchEnd);
      glass.addEventListener(TouchEvent.TOUCH_CANCEL, touchManager.onTouchCancel);
      glass.addEventListener(TouchEvent.TOUCH_MOVE, touchManager.onTouchMove);
      glass.addEventListener(TouchEvent.TOUCH_OUT, touchManager.onTouchOut);
      glass.addEventListener(TouchEvent.TOUCH_OVER, touchManager.onTouchOver);
    }
    
    print("start sound");
    Sounds.playerBackground();
    print("end sound");
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
