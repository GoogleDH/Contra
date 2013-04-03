part of contra;

class HUDManager {
  
  
  TextField tf;
  TextField scoreField;
  Sprite layer;
  int score = 0;
  
  HUDManager(Sprite layer) {
    this.layer = layer;
    tf = new TextField();
    tf.x = 20;
    tf.y = 10;
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
      tf.backgroundColor = Color.Red;
    } else {
      tf.text = "Bomb Ready!";
      tf.backgroundColor = Color.Green;
    }
     
  }
  
  showEnd(){
    print("YOU WIN!");
    TextField t = new TextField();
    t.x = 200;
    t.y = 200;
    t.textColor = Color.White;
    t.text = "YOU WIN!";
    layer.addChild(t);
    
  }
  
}

