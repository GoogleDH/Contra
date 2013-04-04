part of contra;

class Game extends Sprite {

  Sprite _gameLayer;
  Sprite _backgroundLayer;
  Sprite _interfaceLayer;

  
  bool started;
  Juggler juggler;
  Stage stage;

  static Player player;
  static BirdManager birdManager;
  static RobotManager robotManager;
  static BulletManager bulletManager;
  static WorldMap worldMap;
  static DisplayWindow displayWindow;
  static KeyboardHandler keyboardHandler;
  static TouchManager touchManager;
  
  static TextField scoreField;
  static HUDManager hudManager;

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
    birdManager = new BirdManager(_gameLayer);
    bulletManager = new BulletManager(_gameLayer);
    keyboardHandler = new KeyboardHandler(player);
    hudManager = new HUDManager(_interfaceLayer);
    touchManager = new TouchManager();
    
    juggler.add(robotManager);
    juggler.add(birdManager);
    juggler.add(worldMap);
    juggler.add(robotManager);
    juggler.add(bulletManager);
    juggler.add(player);
    juggler.add(keyboardHandler);
   
//    print("start sound");
    Sounds.playBackground();
//    print("end sound");
    touchManager.initEventHandler();
  }

}
