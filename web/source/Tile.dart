part of contra;

class Tile extends Object implements Animatable {
  Bitmap bitmap;
  Tile(){
    
  }
  
  Tile.brick(int i, int j) {
    x = i * 40.0;
    y = j * 40.0;
    width = 40.0;
    height = 40.0;
    speedX = 0.0;
    speedY = 0.0;
    bitmap = new Bitmap(Grafix.resourceManager.getBitmapData("brick"));
    this.addChild(bitmap);
    
    bitmap
      ..x = x - Game.displayWindow.x
      ..y = y;
    juggler.add(this);
  }
  
  Tile.transparentBrick(int i, int j) {
    x = i * 40.0;
    y = j * 40.0;
    width = 40.0;
    height = 40.0;
    speedX = 0.0;
    speedY = 0.0;
    bitmap = new Bitmap(new BitmapData(40, 40, true, 0xFFFFFF));
    this.addChild(bitmap);
    
    bitmap
      ..x = x - Game.displayWindow.x
      ..y = y;
    juggler.add(this);
  }
  
  
  
  bool advanceTime(num time){
    bitmap.x = x - Game.displayWindow.x;
    bitmap.y = y;
  }
  
  String toString(){
    return "Tile: "+super.toString();
  }
}

