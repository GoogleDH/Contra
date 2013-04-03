part of contra;

class Sounds {
  static ResourceManager resourceManager;
  
  static addResource(ResourceManager resourceManager) {
    resourceManager.addSound("background", "sounds/background_music.wav");
    resourceManager.addSound("bomb", "sounds/bomb.wav");
    resourceManager.addSound("clip_change", "sounds/clip_change.wav");
    resourceManager.addSound("player_dead", "sounds/player_dead.wav");
    resourceManager.addSound("rifle", "sounds/rifle.wav");
    resourceManager.addSound("robot_dead", "sounds/robot_dead.wav");
    resourceManager.addSound("robot_fire", "sounds/robot_fire.wav");
    resourceManager.addSound("explosion", "sounds/explosion.wav");
    Sounds.resourceManager = resourceManager;
  }
  
  static playBackground() {
    var sound = resourceManager.getSound("background");
    var soundTransform = new SoundTransform(1, 0);
    var soundChannel = sound.play(true, soundTransform);
    print("music on");
  }
  
  static playSoundEffect(var name) {
    var sound = resourceManager.getSound(name);
    var soundTransform = new SoundTransform(1, 0);
    var soundChannel = sound.play(false, soundTransform);
  }
}

