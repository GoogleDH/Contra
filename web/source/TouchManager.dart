part of contra;

class TouchManager {
  
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

