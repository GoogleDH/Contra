part of contra;

class Statics {
  
  static const int KEY_UP = 38;
  static const int KEY_DOWN = 40;
  static const int KEY_LEFT = 37;
  static const int KEY_RIGHT = 39;
  static const int KEY_JUMP = 32;
  static const int KEY_FIRE = 70;
  static const int KEY_CREATE_ENEMY = 74;
  

  static const double TILE_SIZE = 40.0;
  static const double WORLD_HEIGHT = 480.0;
  static const double BACKGROUND_WIDTH = 800.0;
  static const double BACKGROUND_HEIGHT = 480.0;
  static const double SPEED_X = 280.0;
  static const double SPEED_Y_INITIAL = -600.0;
  static const double SPEED_Y_ACCELERATE = 30.0;
  
  static const int PLAYER_STATE_STAND = 0;
  static const int PLAYER_STATE_MOVE = 1;
  static const int PLAYER_STATE_JUMP = 2;
  static const int PLAYER_STATE_CROUCH = 3;
  
  static const int MIN_FIRE_INTERVAL = 200;
}

