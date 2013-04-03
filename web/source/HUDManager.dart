part of contra;

class HUDManager {
  
  
  TextField tf;
  TextField scoreField;
  TextField blood;
  Sprite layer;
  int score = 0;
  int bloodLeft = 300;
  int bloodRight = 500;
  const int bloodHeight = 5;
  
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
    
//    blood = new TextField();
//    blood.x = 400;
//    blood.y = 10;
//    blood.text = Player.FULL_HP;
//    layer.addChild(blood);
    
  }
  
  void oneBirdKilled() {
    score += 30;
    scoreField.text = score.toString();
  }
  
  void oneRobotKilled() {
    score += 20;
    scoreField.text = score.toString();
  }
  
  void updateBloodStrip(Player player) {
//    blood.text = player.hp.toString() + "/" + Player.FULL_HP;
//    print("update blood");
  }
  
  setBombStatus(bool charging){
    if (charging) {
      tf.text = "Bomb Charging";
      tf.textColor = Color.Red;
    } else {
      tf.text = "Bomb Ready!";
      tf.textColor = Color.Green;
    }
     
  }
  
}

