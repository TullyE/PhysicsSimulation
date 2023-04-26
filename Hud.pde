// Define a class called Hud
class Hud {
  // Declare instance variables for x, y, font size, font, and an array of y-values for buttons
  double x, y;
  double fontSize;
  PFont font;
  int[] numsYButtonArr = new int[] {10, 9, 8, 7, 6, 5, 5, 1};

  // Create an ArrayList to hold buttons and define the constructor for the Hud class
  ArrayList<Button> buttons = new ArrayList<Button>();
  Hud() {
    // Set initial values for font size, font, and y-position
    fontSize = 10;
    font = createFont("Arial-ItalicMT", 10);
    y = 20;
    // Add buttons to the ArrayList with specified parameters (name, x-position, y-position, width, height, button number)
    buttons.add(new Button("Tiny", 0, height - (10 * y), 50, 20, 0)); // 0
    buttons.add(new Button("Small", 0, height - (9 * y), 50, 20, 1)); // 1
    buttons.add(new Button("Medium", 0, height - (8 * y), 50, 20, 2)); // 2
    buttons.add(new Button("Large", 0, height - (7 * y), 50, 20, 3)); // 3
    buttons.add(new Button("Huge", 0, height - (6 * y), 50, 20, 4)); // 4
    buttons.add(new Button("OMFG", 0, height - (5 * y), 50, 20, 5)); // 5
    buttons.add(new Button("Clear", 100, height - (5 * y), 50, 20, 6)); // 6
    //buttons.add(new Button("Paths", 100, height - (4 * y), 50, 20, 8)); // 8
    buttons.add(new Button("Generate proto disk (slow start)", 0, height - (1 * y), 150, 20, 7)); // 7
  }

  // Define a method to update the y-position of the buttons
  void update() {
    for (int i = 0; i < buttons.size(); i ++) {
      buttons.get(i).y = height - numsYButtonArr[i] * 20;
    }
  }

  // Define a method to show the text and buttons on the screen
  void show() {
    // Set the font and font size for the text
    textFont (font);
    textSize((float) fontSize);
    // Set the initial y-position for the text
    y = fontSize;
    // Update and show each button in the ArrayList
    for (Button b : buttons) {
      b.update();
      b.show();
    }
    // Set the fill color to white and the text alignment to left, and display some informational text
    fill(255);
    textAlign(LEFT);
    text("Not to physical scale. Gravitational constant is 1. Particle radius is log of mass. Integration is θ(n^2)Euler.", 0, (float) fontSize);
    // Display the current mass and number of particles
    text("Mass: " + currMass, 0, height - (10.5 * 20));
    text("Particle Num: " + particles.size(), 0, height - (3 * 20));
  }

  // Define a method to handle logic when the mouse is pressed
  void mousePressedLogic() {
    for (Button b : buttons) {
      b.mousePressedLogic();
    }
  }

  // Define a method to handle logic when the mouse is released
  void mouseReleasedLogic() {
    for (Button b : buttons) {
      b.mouseReleasedLogic();
    }
  }
}
