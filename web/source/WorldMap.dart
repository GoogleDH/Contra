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
    this.width = 10000.0;
    print("after add assign width.");
    this.height = Statics.BACKGROUND_HEIGHT;
    print("before add skybitmap");
    skyBitmap = new Bitmap(Grafix.resourceManager.getBitmapData("background"));
    skyBitmap2 = new Bitmap(Grafix.resourceManager.getBitmapData("background"));
    addChild(skyBitmap);
    skyBitmap2.pivotX = - skyBitmap.width + skyBitmap.pivotX;
    addChild(skyBitmap2);

    // background tiles
    for (int i = 0; i < Statics.BACKGROUND_WIDTH / Statics.TILE_SIZE + 20; i++) {
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
    this.bricks = new List<Tile>();
    loadMap();
  }

  Map terrain;

  List<Tile> bricks;
  List<Tile> ends = new List<Tile>();
  
  void loadMap(){
    html.HttpRequest.getString('map.json').then((mapAsJson){
//      print(mapAsJson);
      Map parsedMap = parse(mapAsJson);
      print(parsedMap["terrain"]["width"]);
      terrain = parsedMap['terrain'];
      this.width = terrain['width']  * 40.0;
      for(int i = 0 ; i < terrain['width'] ; i++){
        for(int j = 0 ; j < terrain['height'] ; j++){
          String c = terrain['tiles'][j][i];
          switch (c) {
            case '0': 
              //blank tile
              break;
            case '1':
              //brick
              addBrick_(i, j);
              break;
            case '2':
              //enemy
              createRobot_(i, j);
              break;
            case '3':
              addTransparentBrick_(i, j);
              break;
            case '4':
              addDestinationTile(i, j);
              break;
            case '5':
              addBird(i, j);
              break;
          }
        }
      }
    });
  }
  
  addBird(int i, int j) {
    try{
      print("try to add bird");
      Game.birdManager.createNewBird(i * 40.0, j * 40.0);
    }catch(e){
      print("Error in create robot" + e.toString());
    }
  }
  
  addDestinationTile(int i, int j) {
    Tile brick = new Tile.transparentBrick(i, j);
    addChild(brick);
    ends.add(brick);
  }
  
  createRobot_(int i, int j) {
    try{
      Game.robotManager.createNewRobot(i * 40.0, j * 40.0, 0);
    }catch(e){
      print("Error in create robot $e");
    }
  }
  
  addBrick_(int i, int j){
    Tile brick = new Tile.brick(i, j);
    addChild(brick);
    bricks.add(brick);
  } 
  addTransparentBrick_(int i, int j){
    Tile brick = new Tile.transparentBrick(i, j);
    addChild(brick);
    bricks.add(brick);
  }
  
  
  bool advanceTime(num time) {
    duration += time;
    if (duration > 0.01) {
      double deltaX = cloudMovingSpeed * duration;
      skyBitmap.pivotX += deltaX;
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

