part of contra;

class Button extends Sprite {

  TextField textField;

  Button(var text, int x, int y) {
    textField = new TextField();
    textField.defaultTextFormat = new TextFormat('Helvetica,Arial', 16, Color.Black);
    textField.x = x;
    textField.y = y;
    textField.text = text;
    addChild(textField);
  }
}

