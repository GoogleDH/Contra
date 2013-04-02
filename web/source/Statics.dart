part of contra;

class Statics {
  
  static int KEY_UP = 38;
  static int KEY_DOWN = 40;
  static int KEY_LEFT = 37;
  static int KEY_RIGHT = 39;
  static int KEY_JUMP = 32;
  static int KEY_FIRE = 70;
  
  static double TILE_SIZE = 40.0;
  static double WORLD_HEIGHT = 480.0;
  static double BACKGROUND_WIDTH = 800.0;
  static double BACKGROUND_HEIGHT = 480.0;
  static double SPEED_X = 80.0;
  static double SPEED_Y_INITIAL = 600.0;
  static double SPEED_Y_ACCELERATE = - 30.0;
  
  static int PLAYER_STATE_STAND = 0;
  static int PLAYER_STATE_MOVE = 1;
  static int PLAYER_STATE_JUMP = 2;
  static int PLAYER_STATE_CROUCH = 3;
}

