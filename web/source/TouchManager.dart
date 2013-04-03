part of contra;

class TouchManager {
  
  void initEventHandler() {
    if (Multitouch.supportsTouchEvents) {
      print("Oh touch screen is supported.");
      Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
      var glass = new GlassPlate(Statics.BACKGROUND_WIDTH, Statics.BACKGROUND_HEIGHT);
      glass.addTo(stage);

      glass.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
      glass.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
      glass.addEventListener(TouchEvent.TOUCH_CANCEL, onTouchCancel);
      glass.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
      glass.addEventListener(TouchEvent.TOUCH_OUT, onTouchOut);
      glass.addEventListener(TouchEvent.TOUCH_OVER, onTouchOver);
      
    } else {
    }
  }
  
  void onTouchBegin(TouchEvent touchEvent) {
    print("touch begin ${touchEvent.stageX} ${touchEvent.stageY}");
  }

  void onTouchEnd(TouchEvent touchEvent) {
    print("touche end ${touchEvent.stageX} ${touchEvent.stageY}");
  }

  void onTouchCancel(TouchEvent touchEvent) {
    print("touch cancel ${touchEvent.stageX} ${touchEvent.stageY}");
  }

  void onTouchMove(TouchEvent touchEvent) {
    print("touch move${touchEvent.stageX} ${touchEvent.stageY}");
  }

  void onTouchOut(TouchEvent touchEvent) {
    print("${touchEvent.stageX} ${touchEvent.stageY}");
  }

  void onTouchOver(TouchEvent touchEvent) {
    print("touch over ${touchEvent.stageX} ${touchEvent.stageY}");
  }
  
}

