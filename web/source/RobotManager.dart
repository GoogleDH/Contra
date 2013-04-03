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
    //  createNewRobot(300.0, WorldMap.fixedLeastHeight - 20);
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

  // absolute x, y
  createNewRobot(double x, double y) {

/*    var now = new DateTime.now();
    if (lastCreateTimestamp != null
        && now.millisecondsSinceEpoch - lastCreateTimestamp.millisecondsSinceEpoch < Statics.MIN_FIRE_INTERVAL) {
      return;
    }
    lastCreateTimestamp = now;
*/
    print("create robot");
    Robot robot = new Robot(x, y);
    robots.add(robot);
    layer.addChild(robot);
  }
}

