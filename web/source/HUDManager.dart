part of contra;

class HUDManager {
  
  
  TextField tf;
  TextField scoreField;
  TextField blood;
  TextField leftBlood;
  Sprite layer;
  int score = 0;
  int bloodLeft = 300;
  int bloodRight = 500;
  
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
    print("in HudManager");
    
    leftBlood = new TextField();
    leftBlood.defaultTextFormat = new TextFormat('Helvetica,Arial', 16, Color.Red);
    leftBlood.x = 400;
    leftBlood.y = 10;
    leftBlood.text = Player.FULL_HP.toString();
    layer.addChild(leftBlood);
 
    blood = new TextField();
    blood.defaultTextFormat = new TextFormat('Helvetica,Arial', 16, Color.Green);
    blood.x = 430;
    blood.y = 10;
    blood.text = "/" + Player.FULL_HP.toString();
    layer.addChild(blood);
    
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
    leftBlood.text = player.hp.toString();
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

