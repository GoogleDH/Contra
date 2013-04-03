library contra;

import 'dart:html' as html;
import 'dart:math' as math;
import 'dart:collection';
import 'dart:json';
import 'package:stagexl/stagexl.dart';

part 'source/Collision.dart';
part 'source/Game.dart';
part 'source/Object.dart';
part 'source/WorldMap.dart';
part 'source/Player.dart';
part 'source/Animation.dart';
part 'source/Grafix.dart';
part 'source/Robot.dart';
part 'source/RobotManager.dart';
part 'source/Bullet.dart';
part 'source/BulletManager.dart';
part 'source/DisplayWindow.dart';
part 'source/Statics.dart';
part 'source/KeyboardHandler.dart';
part 'source/Tile.dart';
part 'source/TouchManager.dart';

ResourceManager resourceManager;
RenderLoop renderLoop;
Stage stage;
Juggler juggler = renderLoop.juggler;

void main() {
  stage = new Stage("oneStage", html.query("#oneStage"));
  renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  if (Multitouch.supportsTouchEvents) {
    print("Oh touch screen is supported.");
    Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
  } else {
    html.window.alert('''No touch screen detected!\n\nIf this device has a touch screen, please send a bug report to the StageXL issue tracker on github.''');
  }
 
  resourceManager = new ResourceManager();
  Grafix.addResource(resourceManager);
  
  resourceManager.load().then((res){
    Grafix.resourceManager = resourceManager;
    Game game = new Game(stage, juggler);
    game.start();
    stage.addChild(game);
  }).catchError((error){
    for(var resource in resourceManager.failedResources) {
      print("Loading resource ${resource.kind} ${resource.name} failed: ${resource.error}");
    }
  });
}
