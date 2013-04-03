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
     // createNewRobot(Statics.BACKGROUND_WIDTH + Game.displayWindow.x + 100, WorldMap.fixedLeastHeight - 20, 1);
    }
    if(random.nextDouble() < 0.005) {
     // createNewRobot(Game.displayWindow.x - 100, WorldMap.fixedLeastHeight - 20, 0);
    }
    
    destroyDeadRobot();
  }

  destroyDeadRobot() {
    HashSet<Robot> robotsToRemove = new HashSet<Robot>();

    for(Robot robot in robots) {
      if (robot.isDead) {
        robotsToRemove.add(robot);
        robot.Bleed(() {
          try{
            layer.removeChild(robot);
          }catch(e){
            // ignore
          }
          try {
            robot.destroy();
          } catch (e) {
            // ignore
          }
        });
      }
    }
    robots.removeAll(robotsToRemove);
  }
  
  getAllRobots() {
    return robots;
  }

  // absolute x, y
  createNewRobot(double x, double y, int direction) {
//    print("create robot");
    Robot robot = new Robot(x, y);
    robot.changeDirection(direction);
    robots.add(robot);
    layer.addChild(robot);
  }
}

