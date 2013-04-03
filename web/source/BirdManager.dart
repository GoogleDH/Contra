part of contra;

class BirdManager implements Animatable {
  
  List<Bird> birds;
  Sprite layer;
  DateTime lastCreateTimestamp;
  math.Random random = new math.Random(new DateTime.now().millisecondsSinceEpoch);

  BirdManager(Sprite layer) {
    this.layer = layer;
    birds = new List<Bird>();
  }

  bool advanceTime(num time) {
    if(random.nextDouble() > 0.995) {
      print("create one bird.");
      createNewBird(300.0, 20.0);
    }
    destroyDeadRobot();
  }

  destroyDeadRobot() {
    HashSet<Bird> birdsToRemove = new HashSet<Bird>();

    for(Bird bird in birds) {
      if (bird.isDead) {
        birdsToRemove.add(bird);
        bird.Bleed(() {
          layer.removeChild(bird);
          bird.destroy();
        });
      }
    }
    birds.removeAll(birdsToRemove);
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
    Bird bird = new Bird(x, y);
    birds.add(bird);
    layer.addChild(bird);
  }
}
