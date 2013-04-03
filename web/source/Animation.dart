part of contra;

class Animation {
  List<AnimationFrame> frames = new List<AnimationFrame>();
  int currentIndex;
  double duration;
  Player player;
  var name;
  static double FOREVER = -1.0;

  Animation(Player player) {
    currentIndex = 0;
    duration = 0.0;
    this.player = player;
  }

  start() {
    player.addChild(frames[0].bitmap);
    currentIndex = 0;
    duration = 0.0;
  }

  stop() {
    player.removeChild(frames[currentIndex].bitmap);
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
      stop();
      // Future.wait(removed).then((_) {
      if (currentIndex + 1 == frames.length) {
        currentIndex = 0;
      } else {
        currentIndex = currentIndex + 1;
      }
      frames[currentIndex].bitmap.x = player.x;
      frames[currentIndex].bitmap.y = player.y;

      player.addChild(frames[currentIndex].bitmap);
      duration = duration - frame.duration;
      // });
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

