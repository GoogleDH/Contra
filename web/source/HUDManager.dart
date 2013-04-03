part of contra;

class HUDManager {
  Sprite layer;
  HUDManager(Sprite layer) {
    this.layer = layer;
    tf = new TextField();
    tf.x = 100;
    tf.y = 100;
    layer.addChild(tf);
  }
  
  TextField tf;
  
  setBombStatus(bool charging){
    if (charging) {
      tf.text = "Bomb Charging";
    } else {
      tf.text = "Bomb Ready!";
    }
     
  }
  
}

