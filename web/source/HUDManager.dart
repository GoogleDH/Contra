part of contra;

class HUDManager {
  
  
  TextField tf;
  TextField scoreField;
  Sprite layer;
  int score = 0;
  
  HUDManager(Sprite layer) {
    this.layer = layer;
    tf = new TextField();
    tf.x = 100;
    tf.y = 100;
    layer.addChild(tf);
    
    scoreField = new TextField();
    scoreField.defaultTextFormat = new TextFormat('Helvetica,Arial', 16, Color.Black);
    scoreField.x = Statics.BACKGROUND_WIDTH - 60;
    scoreField.y = 10;
    layer.addChild(scoreField);
    scoreField.text = score.toString();
  }
  
  void oneBirdKilled() {
    score += 30;
    scoreField.text = score.toString();
  }
  
  void oneRobotKilled() {
    score += 20;
    scoreField.text = score.toString();
  }
  
  setBombStatus(bool charging){
    if (charging) {
      tf.text = "Bomb Charging";
    } else {
      tf.text = "Bomb Ready!";
    }
     
  }
  
}

