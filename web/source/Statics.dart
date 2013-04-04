part of contra;

class Statics {

  static const int KEY_UP = 38;
  static const int KEY_DOWN = 40;
  static const int KEY_LEFT = 37;
  static const int KEY_RIGHT = 39;
  static const int KEY_JUMP = 32;
  static const int KEY_FIRE = 65;
  static const int KEY_BOMB = 70;
  static const int KEY_CREATE_ENEMY = 74;


  static const double TILE_SIZE = 40.0;
  static const double WORLD_HEIGHT = 480.0;
  static double BACKGROUND_WIDTH = 1280.0;
  static const double BACKGROUND_HEIGHT = 480.0;
  static const double SPEED_X = 280.0;
  static const double SPEED_X_ACCELERATE = 3.0;
  static const double SPEED_X_MAX = 450.0;
  static const double SPEED_Y_INITIAL = -15.0;
  static const double SPEED_Y_ACCELERATE = 1.0;

  static const int PLAYER_STATE_STAND = 0;
  static const int PLAYER_STATE_MOVE = 1;
  static const int PLAYER_STATE_JUMP = 2;
  static const int PLAYER_STATE_CROUCH = 3;
  static const int PLAYER_STATE_DEAD = 4;

  static const int DIRECTION_LEFT = -1;
  static const int DIRECTION_RIGHT = 1;

  static const int MIN_FIRE_INTERVAL = 200;
  static const double HELICOPTER_SPEED_X = 120.0;
}

