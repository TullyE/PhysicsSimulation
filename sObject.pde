// Define the sObject class
class sObject {
  // Declare the instance variables
  Vector location, velocity, acceleration; // Three vectors to represent the object's position, velocity, and acceleration
  ArrayList<Vector> history; // An ArrayList to store the object's position history
  color c; // A color to use when drawing the object
  double mass; // The object's mass
  double size; // The object's size
  int r;
  int g;
  int b;

  // Declare some other instance variables
  boolean checked, remove; // Two booleans to keep track of whether the object has been checked and whether it should be removed
  Vector runningVector; // A vector used for calculations

  // Define the constructor
  sObject(Vector location, Vector velocity, Vector acceleration, double mass) {
    // Set the instance variables to the values passed in as arguments
    this.location = location;
    this.velocity = velocity;
    this.acceleration = acceleration;
    this.mass = mass;

    // Create a new ArrayList to store the object's position history
    history = new ArrayList<Vector>();

    c = color(0, 255, 0);
    //println(r + ", " + g + ", " + b);
    // Set the runningVector to (0, 0)
    runningVector = new Vector(0, 0);

    // Set checked and remove to false
    checked = false;
    remove = false;
  }

  // Define a method to move the object
  void move() {
    // If showTrails is true, add the current location to the history ArrayList
    if (showTrails) {
      history.add(location.cloneVector());
    }
    // Update the velocity and location vectors based on the acceleration
    velocity.addVector(acceleration);
    location.addVector(velocity);
  }

  // Define a method to show the object on the screen
  void show() {
    // Set the fill and stroke colors to c
    //c = color(255, 255 - Math.round(this.mass / 39216) * 2, 255 - Math.round(this.mass / 39216) * 2);
    c = getColor((int) this.mass);
    fill(c);
    stroke(c);

    // Draw an ellipse at the object's location with a size based on the object's mass
    ellipse((float) location.x, (float) location.y, (float) Math.max(Math.log(mass), 2), (float) Math.max(Math.log(mass), 2));

    // Call the drawTrail method to draw the object's position history
    drawTrail();
  }

  // Define a method to add a force to the object's acceleration vector
  void addForce(Vector v) {
    acceleration.addVector(v);
  }

  // Define a method to set the object's location vector
  void setLocation(Vector loc) {
    location = loc;
  }

  // Define a method to draw the object's position history
  void drawTrail() {
    // If showTrails is true, draw a line connecting all the points in the history ArrayList
    if (showTrails) {
      noFill();
      beginShape();
      stroke(c);
      for (Vector v : history) {
        vertex((float) v.x, (float) v.y);
      }
      endShape();
    }
  }

  // Define a method to get the magnitude of the object's velocity vector
  double get_velocity_size() {
    return Math.sqrt(Math.pow(this.velocity.x, 2) + Math.pow(this.velocity.y, 2));
  }

  // Define a method to convert the object to a string
  public String toString() {
    String fs = ">>>sObject - " + super.toString() + "<<<\n\t";
    fs = fs + "Mass: " + this.mass + "\n\t";
    fs = fs + "Velocity: " + this.velocity + "\n\t";
    fs = fs + "Acceleration: " + this.acceleration + "\n\t";
    fs = fs + "Location: " + this.location + "\n";
    return fs;
    //return ">>>sObject<<<\n\t" + "Mass: " + this.mass + "\n\t Velocity: " + this.velocity;
  }

  public color getColor(int value) {
    // Define the RGB values for white and orange
    int[] white = {255, 255, 255};  // RGB values for white
    int[] orange = {255, 165, 0};   // RGB values for orange
    int[] red = {255, 0, 0}; // RGB values for red
    if (this.mass <= 1000000) {
      double ratio = Math.log10(value) / Math.log10(1000000);  // Calculate the ratio using a logarithmic scale
      int[] color_ = new int[3];
      for (int i = 0; i < 3; i++) {
        color_[i] = (int) (white[i] + (orange[i] - white[i]) * ratio * ratio);  // Interpolate the RGB values using the ratio squared
      }
      return color(color_[0], color_[1], color_[2]);
    } else {
      double ratio = Math.log10(value - 1000000) / Math.log10(9000000);  // Calculate the ratio using a logarithmic scale
      int[] color_ = new int[3];
      for (int i = 0; i < 3; i++) {
        color_[i] = (int) (orange[i] + (red[i] - orange[i]) * ratio * ratio);  // Interpolate the RGB values using the ratio squared
      }
      return color(color_[0], color_[1], color_[2]);
    }
  }
}
