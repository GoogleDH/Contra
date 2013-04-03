part of contra;

class RobotManager implements Animatable {
  List<Robot> robots;
  Sprite layer;
  DateTime lastCreateTimestamp;
  math.Random random = new math.Random(new DateTime.now().millisecondsSinceEpoch);

  RobotManager(Sprite layer) {
    this.layer = layer;
    robots = new List<Robot>();
  }

  bool advanceTime(num time) {
    if(random.nextDouble() > 0.995) {
      createNewRobot();
    }
    destroyDeadRobot();
  }

  destroyDeadRobot() {
    HashSet<Robot> robotsToRemove = new HashSet<Robot>();

    for(Robot robot in robots) {
      if (robot.isDead) {
        layer.removeChild(robot);
        robotsToRemove.add(robot);
        robot.destroy();
      }
    }
    robots.removeAll(robotsToRemove);
  }
  
  getAllRobots() {
    return robots;
  }

  createNewRobot() {
    var now = new DateTime.now();
    if (lastCreateTimestamp != null
        && now.millisecondsSinceEpoch - lastCreateTimestamp.millisecondsSinceEpoch < Statics.MIN_FIRE_INTERVAL) {
      return;
    }
    lastCreateTimestamp = now;

    print("create robot");
    Robot robot = new Robot(0,400.0,400.0);
    robots.add(robot);
    layer.addChild(robot);
  }
}

