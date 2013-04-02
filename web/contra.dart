library contra;

import 'dart:html' as html;
import 'dart:math';
import 'dart:collection';
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

ResourceManager resourceManager;
RenderLoop renderLoop;
Stage stage;
Juggler juggler = renderLoop.juggler;

void main() {
  stage = new Stage("oneStage", html.query("#oneStage"));
  renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  
  resourceManager = new ResourceManager();
  resourceManager.addBitmapData("background", "images/background.png");
  resourceManager.addBitmapData("tiledirt", "images/tiledirt.png");
  resourceManager.addBitmapData("tileocean", "images/tileocean.png");
  resourceManager.addBitmapData("bulletleft", "images/bulletleft.png");
  resourceManager.addBitmapData("bulletright", "images/bulletright.png");
  
  resourceManager.load().then((res){
    Grafix.resourceManager = resourceManager;
    Game game = new Game(juggler);
    game.start();
    stage.addChild(game);
  }).catchError((error){
    for(var resource in resourceManager.failedResources) {
      print("Loading resource ${resource.kind} ${resource.name} failed: ${resource.error}");
    }
  });
}
