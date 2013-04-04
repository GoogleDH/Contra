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
part 'source/Bird.dart';
part 'source/Robot.dart';
part 'source/RobotManager.dart';
part 'source/BirdManager.dart';
part 'source/Bullet.dart';
part 'source/BulletManager.dart';
part 'source/DisplayWindow.dart';
part 'source/Statics.dart';
part 'source/KeyboardHandler.dart';
part 'source/Tile.dart';
part 'source/TouchManager.dart';
part 'source/Sounds.dart';
part 'source/HUDManager.dart';

ResourceManager resourceManager;
Stage stage;
Juggler juggler;

void main() {
  var canvas = html.query("#oneStage");
  
  
  stage = new Stage("oneStage", canvas);
  RenderLoop renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  juggler = renderLoop.juggler;
 
  resourceManager = new ResourceManager();
  Grafix.addResource(resourceManager);
  Sounds.addResource(resourceManager);
  
  resourceManager.load().then((res){
    Grafix.resourceManager = resourceManager;
    Game game = new Game(stage, renderLoop.juggler);
    stage.addChild(game);
    game.start();
  }).catchError((error){
    for(var resource in resourceManager.failedResources) {
      print("Loading resource ${resource.kind} ${resource.name} failed: ${resource.error}");
    }
  });
  
}
