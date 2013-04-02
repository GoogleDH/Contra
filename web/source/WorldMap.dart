// World map
part of contra;

class WorldMap extends Sprite implements Animatable {
  
  Bitmap skyBitmap;
  Bitmap skyBitmap2;
  double cloudMovingSpeed = 20.0;
  double duration;
  int height;
  int width;
  DisplayWindow displayWindow;
  
  static int fixedLeastHeight = Statics.WORLD_HEIGHT - Statics.TILE_SIZE;
  List<int> terrainHeights = new List<int>();
  
  WorldMap() {   
    print("before add assign window.");
    displayWindow = Game.displayWindow;
    print("after add assign window.");
    width = 10000;
    print("after add assign width.");
    height = displayWindow.height;
    print("before add skybitmap");
    skyBitmap = new Bitmap(Grafix.resourceManager.getBitmapData("background"));
    skyBitmap2 = new Bitmap(Grafix.resourceManager.getBitmapData("background"));
    addChild(skyBitmap);
    skyBitmap2.pivotX = - skyBitmap.width + skyBitmap.pivotX;
    addChild(skyBitmap2);

    // background tiles
    for (int i = 0; i < displayWindow.width / Statics.TILE_SIZE; i++) {
      Bitmap tileDirt = new Bitmap(Grafix.resourceManager.
                                   getBitmapData("tiledirt"));
      tileDirt.pivotX = - i * Statics.TILE_SIZE;
      tileDirt.pivotY = - (Statics.BACKGROUND_HEIGHT - Statics.TILE_SIZE);
      addChild(tileDirt);
      Bitmap tileOcean = new Bitmap(Grafix.resourceManager.
                                    getBitmapData("tileocean"));
      tileOcean.pivotX = - i * Statics.TILE_SIZE;
      tileOcean.pivotY = - (Statics.BACKGROUND_HEIGHT - 2 * Statics.TILE_SIZE);
      addChild(tileOcean);
    }
    duration = 0.0;
  }
  
  bool advanceTime(num time) {
    duration += time;
    if (duration > 0.2) {
      double deltaX = cloudMovingSpeed * duration;
      skyBitmap.pivotX += deltaX.toInt();
      skyBitmap2.pivotX = - skyBitmap.width + skyBitmap.pivotX;
      if (skyBitmap2.pivotX > 0) {
        Bitmap tmp = skyBitmap;
        skyBitmap = skyBitmap2;
        skyBitmap2 = tmp;
      }
      duration = 0.0;
    }
    return true;
  }
  
  
  // return the left bound of a object;
  leftBound(Object object) {
    
  }
  
  rightBound(Object object) {
    
  }
  
  downBound(Object object) {
    
  }
}

