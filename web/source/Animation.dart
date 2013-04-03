part of contra;

class Animation implements Animatable {
  List<AnimationFrame> frames = new List<AnimationFrame>();
  int currentIndex;
  double duration;
  Sprite sprite;

  static double FOREVER = -1.0;

  Animation(Sprite sprite) {
    currentIndex = 0;
    duration = 0.0;
    this.sprite = sprite;
  }
  
  void start() {
    sprite.addChild(frames[currentIndex].bitmap);
    juggler.add(this);
  }
  
  void stop() {
    juggler.remove(this);
    sprite.removeChild(frames[currentIndex].bitmap);
  }

  bool advanceTime(num time) {
    duration += time;
    if (duration >= frames[currentIndex].duration) {
      duration -= frames[currentIndex].duration;
      sprite.removeChild(frames[currentIndex].bitmap);
      var x = frames[currentIndex].bitmap.x;
      var y = frames[currentIndex].bitmap.y;
      ++currentIndex;
      if (currentIndex == frames.length) {
        currentIndex = 0;
      }
      frames[currentIndex].bitmap.x = x;
      frames[currentIndex].bitmap.y = y;
      sprite.addChild(frames[currentIndex].bitmap);
    }
  }

  addFrame(AnimationFrame frame) {
    frames.add(frame);
  }

  Bitmap getBitmap() {
    return frames[currentIndex].bitmap;
  }
}
class AnimationFrame {
  Bitmap bitmap;
  double duration;

  AnimationFrame(var bitmapName, double duration) {
    this.bitmap = new Bitmap(Grafix.resourceManager.getBitmapData(bitmapName));
    this.duration = duration;
  }
}

