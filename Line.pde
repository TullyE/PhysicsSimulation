// Define a Line class with a beginning and an end vector, and two boolean properties to track if the line is being drawn and if it is paused.
class Line {
  Vector beg, end; // Beginning and end vectors of the line
  boolean drawing = false; // A boolean flag to track if the line is being drawn
  boolean pause = false; // A boolean flag to track if the line is paused

  // Constructor for the Line class
  Line() {
    drawing = false; // Set the initial value of the drawing flag to false
    beg = new Vector(0, 0); // Create a new beginning vector object with x and y coordinates of 0
    end = new Vector(0, 0); // Create a new end vector object with x and y coordinates of 0
  }

  // Update method to update the line's end point based on the current mouse position
  void update() {
    if (drawing) { // If the line is being drawn
      double endX = mouseX - t.translation.x; // Calculate the new x coordinate of the end point of the line
      double endY = mouseY - t.translation.y; // Calculate the new y coordinate of the end point of the line
      end.setVector(endX, endY); // Set the end vector's x and y coordinates to the new values
      show(); // Call the show method to display the line on the screen
    }
  }

  // Show method to display the line on the screen
  void show() {
    stroke(0, 0, 255); // Set the stroke color to white
    fill(0, 0, 250);
    if (drawing) { // If the line is being drawn
      ellipse((float) beg.x, (float) beg.y, 5, 5);
      line((float) beg.x, (float) beg.y, (float) end.x, (float) end.y); // Draw the line using the beginning and end vectors
    }
    stroke(0); // Set the stroke color to black
  }

  // Mouse pressed logic method to handle mouse press events
  void mousePressedLogic() {
    if (mouseY > height - 200 && mouseX < 150) {
    } // If the mouse is in a specific area of the screen, do nothing
    else if (!t.moving) { // If the scene is not moving
      drawing = true; // Set the drawing flag to true
      beg.setVector(mouseX - t.translation.x, mouseY - t.translation.y); // Set the beginning vector to the current mouse position
    }
  }

  // Mouse released logic method to handle mouse release events
  void mouseReleasedLogic() {
    drawing = false; // Set the drawing flag to false
    if (drawing) { // If the line was being drawn
      spawnNewParticle(); // Call the spawnNewParticle method to create a new particle
    }
  }

  // Key pressed logic method to handle key press events
  void keyPressedLogic(Integer kCode) {
    if (kCode == 157 || kCode == 17) { // If the user presses the ctrl or command key
      drawing = false; // Set the drawing flag to false
    }
  }
}
