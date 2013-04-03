part of contra;

class Grafix {
  static ResourceManager resourceManager;
  
  static addResource(ResourceManager resourceManager) {
    resourceManager.addBitmapData("background", "images/background.png");
    resourceManager.addBitmapData("tile1", "images/tile1.png");
    resourceManager.addBitmapData("tile2", "images/tile2.png");
    resourceManager.addBitmapData("tile3", "images/tile3.png");
    resourceManager.addBitmapData("tiledirt", "images/tiledirt.png");
    resourceManager.addBitmapData("tileocean", "images/tileocean.png");
    resourceManager.addBitmapData("bulletleft", "images/bulletleft.png");
    resourceManager.addBitmapData("bulletright", "images/bulletright.png");
    resourceManager.addBitmapData("player_leftdie", "images/player_leftdie.png");
    resourceManager.addBitmapData("player_rightdie", "images/player_rightdie.png");
    resourceManager.addBitmapData("player_leftcrouch", "images/player_leftcrouch.png");
    resourceManager.addBitmapData("player_rightcrouch", "images/player_rightcrouch.png");
    resourceManager.addBitmapData("player_leftstand", "images/player_leftstand.png");
    resourceManager.addBitmapData("player_rightstand", "images/player_rightstand.png");
    resourceManager.addBitmapData("player_leftrun1", "images/player_leftrun1.png");
    resourceManager.addBitmapData("player_leftrun2", "images/player_leftrun2.png");
    resourceManager.addBitmapData("player_leftrun3", "images/player_leftrun3.png");
    resourceManager.addBitmapData("player_rightrun1", "images/player_rightrun1.png");
    resourceManager.addBitmapData("player_rightrun2", "images/player_rightrun2.png");
    resourceManager.addBitmapData("player_rightrun3", "images/player_rightrun3.png");
    resourceManager.addBitmapData("player_leftjump", "images/player_leftjump.png");
    resourceManager.addBitmapData("player_rightjump", "images/player_rightjump.png");
    resourceManager.addBitmapData("robot_leftblood1", "images/robot_leftblood1.png");
    resourceManager.addBitmapData("robot_leftblood2", "images/robot_leftblood2.png");
    resourceManager.addBitmapData("robot_leftblood3", "images/robot_leftblood3.png");
    resourceManager.addBitmapData("robot_rightblood1", "images/robot_rightblood1.png");
    resourceManager.addBitmapData("robot_rightblood2", "images/robot_rightblood3.png");
    resourceManager.addBitmapData("robot_rightblood3", "images/robot_rightblood3.png");
    resourceManager.addBitmapData("robot_leftmove1", "images/robot_leftmove1.png");
    resourceManager.addBitmapData("robot_leftmove2", "images/robot_leftmove2.png");
    resourceManager.addBitmapData("robot_leftmove3", "images/robot_leftmove3.png");
    resourceManager.addBitmapData("robot_rightmove1", "images/robot_rightmove1.png");
    resourceManager.addBitmapData("robot_rightmove2", "images/robot_rightmove2.png");
    resourceManager.addBitmapData("robot_rightmove3", "images/robot_rightmove3.png");
    resourceManager.addBitmapData("robot_leftstand", "images/robot_leftstand.png");
    resourceManager.addBitmapData("robot_rightstand", "images/robot_rightstand.png");
    resourceManager.addBitmapData("robot_leftshoot", "images/robot_leftshoot.png");
    resourceManager.addBitmapData("robot_rightshoot", "images/robot_rightshoot.png");
    resourceManager.addBitmapData("robot", "images/chicken.png");
    resourceManager.addBitmapData("brick", "images/brick.png");
    resourceManager.addBitmapData("bullet1Left", "images/bullet1Left.png");
    resourceManager.addBitmapData("bullet1Right", "images/bullet1Right.png");
    resourceManager.addBitmapData("helicopter1", "images/helicopter1.png");
    resourceManager.addBitmapData("helicopter2", "images/helicopter2.png");
    resourceManager.addBitmapData("helicopter3", "images/helicopter3.png");
    resourceManager.addBitmapData("helicopter4", "images/helicopter4.png");
    resourceManager.addBitmapData("bullet2", "images/bullet2.png");
    resourceManager.addBitmapData("explosion1", "images/explosion1.png");
    resourceManager.addBitmapData("explosion2", "images/explosion2.png");
    resourceManager.addBitmapData("explosion3", "images/explosion3.png");
    
    Grafix.resourceManager = resourceManager;
  }
}

