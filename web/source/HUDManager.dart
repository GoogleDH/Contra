part of contra;

class HUDManager {
  
  
  TextField tf;
  TextField scoreField;
  
  Bitmap blood_background;
  Bitmap blood_real;
  
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
    
    // HP 
    blood_background = new Bitmap(new BitmapData(300, 15, false, Color.Red));
    blood_real = new Bitmap(new BitmapData(300, 15, false, Color.Green));
    blood_background.x = blood_real.x = 340;
    blood_background.y = blood_real.y = 10;
    layer.addChild(blood_background);
    layer.addChild(blood_real);
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
    double scale = player.hp / Player.FULL_HP;
    if (scale < 0) {
      scale = 0.0;
    }
    blood_real.scaleX = scale;
   // leftBlood.text = player.hp.toString();
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
  
  showEnd(bool win){
    TextField t = new TextField();
    t.x = 440;
    t.y = 200;
    t.width = 700;
    if (win) {
      t.defaultTextFormat = new TextFormat('Helvetica,Arial', 80, Color.Chocolate);
      t.text = "YOU WIN!";
    } else {
      t.defaultTextFormat = new TextFormat('Helvetica,Arial', 80, Color.Red);
      t.text = "GAME OVER!";
    }
    
    layer.addChild(t);  
  }
  
}

