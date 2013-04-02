part of contra;

class Bullet extends Object implements Animatable { 
 bool fromPlayer; // hostile to player or not
  
  int life; //frames before it kills itself

  double initX;
  double initY;
  
  Bullet(){
  }

  var bitmap;
  
  Bullet.byType(hostile) {
    fromPlayer = hostile;
    
  }
  
  Bullet.full(double x, double y, double speedX, double speedY, bool hostile) {
    this
      ..x = x
      ..y = y
      ..speedX = speedX
      ..speedY = speedY
      ..fromPlayer = hostile
      ..initX = x
      ..initY = y;
    if(speedX > 0)
      bitmap = new Bitmap(Grafix.resourceManager.getBitmapData("bulletright"));
    else 
      bitmap = new Bitmap(Grafix.resourceManager.getBitmapData("bulletleft"));
    this.addChild(bitmap);
    juggler.add(this);
  }
    
  bool advanceTime(num time) {
    x = x + speedX;
    y = y + speedY;
    //print("Helloaaa x:"+this.x.toString()+" y:"+this.y.toString());
    // Update x,y
    bitmap.x=x;
    bitmap.y=y;
  }
  
  bool isDead() {
    return (x-initX)*(x-initX)+(y-initY)*(y-initY) > 40000;
  }
}

