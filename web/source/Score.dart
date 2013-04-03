part of contra;

class Score {
  
  int score;
  
  void oneBirdKilled() {
    score += 30;
  }
  
  void oneRobotKilled() {
    score += 20;
  }
  
}

