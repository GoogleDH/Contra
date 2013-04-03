part of contra;

class BirdManager implements Animatable {
  
  List<Bird> birds;
  Sprite layer;
  DateTime lastCreateTimestamp;
  math.Random random = new math.Random(new DateTime.now().millisecondsSinceEpoch);

  BirdManager(Sprite layer) {
    this.layer = layer;
    robots = new List<Bird>();
  }

  bool advanceTime(num time) {
    if(random.nextDouble() > 0.995) {
      createNewRobot(300.0, WorldMap.fixedLeastHeight - 20);
    }
    destroyDeadRobot();
  }

  destroyDeadRobot() {
    HashSet<Bird> birdsToRemove = new HashSet<Bird>();

    for(Bird bird in birds) {
      if (robot.isDead) {
        birdsToRemove.add(bird);
        birds.Bleed(() {
          layer.removeChild(bird);
          bird.destroy();
        });
      }
    }
    birds.removeAll(robotsToRemove);
  }
  
  getAllBirds() {
    return birds;
  }

  // absolute x, y
  createNewBird(double x, double y) {

/*    var now = new DateTime.now();
    if (lastCreateTimestamp != null
        && now.millisecondsSinceEpoch - lastCreateTimestamp.millisecondsSinceEpoch < Statics.MIN_FIRE_INTERVAL) {
      return;
    }
    lastCreateTimestamp = now;
*/
    print("create robot");
    Bird bird = new Bird(x, y);
    birds.add(bird);
    layer.addChild(bird);
  }
}
