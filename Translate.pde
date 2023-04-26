class Translate {
  // Vector objects to keep track of translation, mouse movement, and start position
  Vector translation;
  Vector mouseStart;
  Vector mouseEnd;
  Vector mouseChange;
  Vector translationStart;

  // boolean variable to check if the object is currently moving
  boolean moving;

  // constructor to initialize the class variables
  Translate() {
    translation = new Vector(width/2, height/2);
    mouseStart = new Vector(0, 0);
    mouseEnd = new Vector(0, 0);
    mouseChange = new Vector(0, 0);
    translationStart = new Vector( 0, 0);
    moving = false;
  }

  // method to update the translation based on the mouse movement
  void update() {
    mouseEnd.setVector(mouseX, mouseY);
    if (moving) {
      mouseChange = new Vector(mouseStart.x - mouseEnd.x, mouseStart.y - mouseEnd.y);
      translation.setVector(translationStart.x - mouseChange.x, translationStart.y - mouseChange.y);
    }
  }

  // method to check if the left mouse button is pressed
  void mousePressedLogic() {
    if (keyPressed && !moving) {
      moving = true;
      startMoving();
    }
  }

  // method to check if the left mouse button is released
  void mouseReleasedLogic() {
    moving = false;
  }

  // method to check if the control key and left mouse button are pressed
  void keyPressedLogic(Integer kCode) {
    if (mousePressed && !moving && (kCode == 157 || kCode == 17)) {
      moving = true;
      startMoving();
    }
  }

  // method to check if the control key is released
  void keyReleasedLogic(Integer kCode) {
    if (moving && (kCode == 157 || kCode == 17)) {
      moving = false;
    }
  }

  // method to set the start position of the mouse and translation when moving starts
  void startMoving() {
    showTrails = false; // not sure what this does
    for(sObject o : particles) { // not sure what this does
      o.history.clear(); // not sure what this does
    }
    mouseStart.setVector(mouseX, mouseY);
    translationStart.setVector(t.translation.getX(), t.translation.getY());
  }
}
