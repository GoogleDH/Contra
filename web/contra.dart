library contra;

import 'dart:html' as html;
import 'dart:math' as math;
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
part 'source/KeyboardHandler.dart';

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
  resourceManager.addBitmapData("player_dead", "images/player_die.png");
  resourceManager.addBitmapData("player_leftcrouch", "images/player_leftcrouch.png");
  resourceManager.addBitmapData("player_rightcrouch", "images/player_rightcrouch.png");
  resourceManager.addBitmapData("player_leftstand", "images/player_leftstand.png");
  resourceManager.addBitmapData("player_rightstand", "images/player_rightstand.png");
  resourceManager.addBitmapData("player_leftrun1", "images/player_leftrun1.png");
  resourceManager.addBitmapData("player_leftrun2", "images/player_leftrun2.png");
  resourceManager.addBitmapData("player_leftrun3", "images/player_leftrun3.png");
  resourceManager.addBitmapData("player_rightrun1", "images/player_rightstand.png");
  resourceManager.addBitmapData("player_rightrun2", "images/player_rightstand.png");
  resourceManager.addBitmapData("player_rightrun3", "images/player_rightstand.png");
  
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
