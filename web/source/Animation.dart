part of contra;

class Animation {
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
  
  start() {
    sprite.addChild(frames[0].bitmap); 
  }
  
  stop() {
    // some error cauese currentFrame = null, have to try-catch
    try {
      sprite.removeChild(frames[currentIndex].bitmap);
    } catch (e) {
      
    }
    return true;
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
      var removed = stop();    
      // Future.wait(removed).then((_) {
      if (currentIndex + 1 == frames.length) {
        currentIndex = 0;
      } else {
        currentIndex = currentIndex + 1;
      }
        sprite.addChild(frames[currentIndex].bitmap);
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

