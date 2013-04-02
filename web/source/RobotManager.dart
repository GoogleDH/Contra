part of contra;

class RobotManager implements Animatable {
  List<Robot> robots;
  
  RobotManager() {
    robots = new List<Robot>();
  }
  
  bool advanceTime(num time) {
    destroyDeadRobot();
    createNewRobot();
  }
  
  destroyDeadRobot() {
    for(Robot robot in robots) {
      if (false) {
        robot.destroy();
      }
    }
  }
  
  createNewRobot() {
    
  }
}

