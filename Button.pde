/**
 *
 *
 * created by TullyE March 2023
 * last updated April 11 2023
 */
class Button {
  int bID;           // ID of the button
  double x, y;       // x and y position of the button
  double w, h;       // width and height of the button
  String label;      // label of the button
  color c;           // color of the button
  boolean hovered;   // whether the mouse is hovering over the button
  boolean clicked;   // whether the button has been clicked

  // Constructor for the button
  Button(String label_, double x_, double y_, double w_, double h_, int bID_) {
    this.x = x_;    // set x position
    this.y = y_;    // set y position
    this.label = label_;  // set label
    this.w = w_;    // set width
    this.h = h_;    // set height
    c = 255;        // set initial color to white
    bID = bID_;     // set button ID
  }

  // Update the button's color based on whether the mouse is hovering over it or it has been clicked
  void update() {
    if (touchingMouse()) {
      c = 200;      // if mouse is hovering, change color to gray
      if (clicked) {
        c = 100;    // if clicked, change color to darker gray
      }
    } else {
      if (clicked && !touchingMouse()) {
        c = 200;    // if clicked and mouse is not hovering, keep color gray
      } else {
        c = 255;    // otherwise, keep color white
      }
    }
  }

  // Display the button on the screen
  void show() {
    fill(c);                      // set fill color
    stroke(0);                    // set stroke color to black
    rect((float) x, (float) y, (float)  w, (float)  h);  // draw rectangle
    fill(0);                      // set text color to black
    textAlign(CENTER);            // center text
    text(label, (float) (x + w/2), (float) (y + h/2));  // display label inside the button
  }

  // Check whether the mouse is touching the button
  boolean touchingMouse() {
    if ((mouseX > this.x && mouseX < this.x + w) && (mouseY > this.y && mouseY < this.y + h)) {
      return true;
    }
    return false;
  }

  // Set the clicked variable to true if the button is clicked
  void mousePressedLogic() {
    if (touchingMouse()) {
      clicked = true;
    }
  }

  // Perform an action when the button is released
  void mouseReleasedLogic() {

    if (touchingMouse() && clicked) {
      buttonPressed();     // call the buttonPressed() method
      clicked = false;     // reset clicked variable
    }
    clicked = false;       // reset clicked variable
  }

  // Perform an action based on the button ID
  void buttonPressed() {
    if (bID == 0) {
      currMass = 1;         // set the current mass to 1
    } else if (bID == 1) {
      currMass = 1000;      // set the current mass to 1000
    } else if (bID == 2) {
      currMass = 10000;     // set the current mass to 10000
    } else if (bID == 3) {
      currMass = 100000;    // set the current mass to 100000
    } else if (bID == 4) {
      currMass = 1000000;   // set the current mass to 1000000
    } else if (bID == 5) {
      currMass = 10000000;  // set the current mass to 1000000
    } else if (bID == 6) {
      particles.removeAll(particles);  // remove all of the particles from the screen
    } else if (bID == 7) {
      println("7");  //generate a protodis
    } else if (bID == 8) {
      showTrails = !showTrails;
    }
  }
}
