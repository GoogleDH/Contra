part of contra;

class Sounds {
  static ResourceManager resourceManager;
  
  static addResource(ResourceManager resourceManager) {
    resourceManager.addSound("background", "sounds/background_music.wav");
    Sounds.resourceManager = resourceManager;
  }
  
  static playerBackground() {
    var sound = resourceManager.getSound("background");
    var soundTransform = new SoundTransform(1, 0);
    var soundChannel = sound.play(true, soundTransform);
    print("music on");
  }
}

