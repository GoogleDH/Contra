part of contra;

class Score {
  
  int score = 0;
  TextField scoreField;
  
  Score(TextField scoreField) {
    this.scoreField = scoreField;
  }
  
  void oneBirdKilled() {
    score += 30;
    scoreField.text = score.toString();
  }
  
  void oneRobotKilled() {
    score += 20;
    scoreField.text = score.toString();
  }
  
}

