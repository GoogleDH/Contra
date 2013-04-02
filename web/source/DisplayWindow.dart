part of contra;

class DisplayWindow implements Animatable {
  int x;
  int y;
  int width;
  int height;
  
  DisplayWindow() {
    this.width = Statics.BACKGROUND_WIDTH;
    this.height = Statics.BACKGROUND_HEIGHT;
  }
  
  updateAbosultePos(Object object) {
    // update rx,ry in Object
  }
  
  bool advanceTime(num time) {
    // update x,y;
  }
}


