part of contra;

class DisplayWindow {

  double width;
  double height;
  double x;
  double y;

  DisplayWindow() {
    this.width = Statics.BACKGROUND_WIDTH;
    this.height = Statics.BACKGROUND_HEIGHT;
    this.x = 0.0;
    this.y = 0.0;
  }

  updateAbosultePos(Player player) {
    // update x,y;
    WorldMap worldMap = Game.worldMap;

    if (player.x - this.x >  this.width * 3 / 5) {
      double right = math.min(worldMap.width - this.width, player.x - 3 * this.width / 5);
      this.x = right;
    } else if (player.x - this.x < this.width * 2 / 5) {
      double left = math.max(0.0, player.x - this.width * 2 / 5);
      this.x = left;
    }
    
  }
}


