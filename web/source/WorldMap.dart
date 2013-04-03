// World map
part of contra;

class WorldMap extends Object implements Animatable {

  Bitmap skyBitmap;
  Bitmap skyBitmap2;
  double cloudMovingSpeed = 20.0;
  double duration;

  static double fixedLeastHeight = Statics.WORLD_HEIGHT - Statics.TILE_SIZE;
  List<int> terrainHeights = new List<int>();
  List<Bitmap> tileDirts = new List<Bitmap>();
  List<Bitmap> tileOceans = new List<Bitmap>();

  WorldMap() {
    print("before add assign window.");
    this.width = 10000;
    print("after add assign window.");
    print("after add assign width.");
    this.height = Statics.BACKGROUND_HEIGHT;
    print("before add skybitmap");
    skyBitmap = new Bitmap(Grafix.resourceManager.getBitmapData("background"));
    skyBitmap2 = new Bitmap(Grafix.resourceManager.getBitmapData("background"));
    addChild(skyBitmap);
    skyBitmap2.pivotX = - skyBitmap.width + skyBitmap.pivotX;
    addChild(skyBitmap2);

    // background tiles
    for (int i = 0; i < Statics.BACKGROUND_WIDTH / Statics.TILE_SIZE + 2; i++) {
      Bitmap tileDirt = new Bitmap(Grafix.resourceManager.
                                   getBitmapData("tiledirt"));
      tileDirt.x = i * Statics.TILE_SIZE;
      tileDirt.y = (Statics.BACKGROUND_HEIGHT - Statics.TILE_SIZE);
      addChild(tileDirt);
      tileDirts.add(tileDirt);
      Bitmap tileOcean = new Bitmap(Grafix.resourceManager.
                                    getBitmapData("tileocean"));
      tileOcean.x = i * Statics.TILE_SIZE;
      tileOcean.y = (Statics.BACKGROUND_HEIGHT - 2 * Statics.TILE_SIZE);
      addChild(tileOcean);
      tileOceans.add(tileOcean);
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

    // background tiles
    double offset = -Game.displayWindow.x + (Game.displayWindow.x / Statics.TILE_SIZE).toInt() * Statics.TILE_SIZE;
    for (int i = 0; i < Statics.BACKGROUND_WIDTH / Statics.TILE_SIZE + 2; i++) {
      Bitmap tileDirt = tileDirts.elementAt(i);
      tileDirt.x = offset;
      Bitmap tileOcean = tileOceans.elementAt(i);
      tileOcean.x = offset;
      offset += Statics.TILE_SIZE;
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

