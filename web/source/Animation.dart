part of contra;

class Animation {
  List<AnimationFrame> frames = new List<AnimationFrame>();
  int currentIndex;
  double duration;
  Object obj;
  var name;
  static double FOREVER = -1.0;

  Animation(Object obj) {
    currentIndex = 0;
    duration = 0.0;
    this.obj = obj;
  }

  start() {
    obj.addChild(frames[0].bitmap);
    currentIndex = 0;
    duration = 0.0;
  }

  stop() {
    obj.removeChild(frames[currentIndex].bitmap);
  }

  addFrame(AnimationFrame frame) {
    frames.add(frame);
  }
  
  update(num time) {
    duration += time;
    if (frames.length == 0) {
      return;
    }

    AnimationFrame frame = frames[currentIndex];
    if (frame.duration == FOREVER) {
      return;
    }

    if (duration >= frame.duration) {
      var x = frames[currentIndex].bitmap.x;
      var y = frames[currentIndex].bitmap.y;
      stop();
      if (currentIndex + 1 == frames.length) {
        currentIndex = 0;
      } else {
        currentIndex = currentIndex + 1;
      }
      frames[currentIndex].bitmap.x = x;
      frames[currentIndex].bitmap.y = y;

      obj.addChild(frames[currentIndex].bitmap);
      duration = duration - frame.duration;
    }
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

