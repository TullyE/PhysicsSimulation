class Vector {
  // declare instance variables
  double x, y;

  // constructor
  Vector(double x, double y) {
    this.x = x;
    this.y = y;
  }

  // method to add a vector to this vector
  void addVector(Vector b) {
    this.x += b.x;
    this.y += b.y;
  }

  // method to subtract a vector from this vector
  void subtractVector(Vector b) {
    this.x -= b.x;
    this.y -= b.y;
  }

  // method to subtract a vector from this vector and return a new vector
  public Vector subtractVectorReturnVector(Vector b) {
    return new Vector(this.x - b.x, this.y - b.y);
  }

  // method to get the x-coordinate of this vector
  double getX() {
    return this.x;
  }

  // method to get the y-coordinate of this vector
  double getY() {
    return this.y;
  }

  // method to create a copy of this vector
  Vector copyVector() {
    return new Vector(this.x, this.y);
  }

  // method to set the coordinates of this vector
  void setVector(double x_, double y_) {
    this.x = x_;
    this.y = y_;
  }

  // method to create a clone of this vector
  Vector cloneVector() {
    return new Vector(this.x, this.y);
  }

  // method to scale this vector by a scalar value and return a new vector
  Vector scaleVector(double scaler) {
    return new Vector(this.x * scaler, this.y * scaler);
  }

  // method to add a vector to this vector and return a new vector
  Vector addVectorReturnVector(Vector b) {
    return new Vector(this.x + b.x, this.y + b.y);
  }

  // method to divide this vector by a scalar value and return a new vector
  public Vector divideVectorReturnVector(double scalar) {
    if (scalar == 0) {
      return new Vector(0, 0);
    }
    return new Vector(this.x / scalar, this.y / scalar);
  }

  // override toString method to return a string representation of this vector
  @Override
    String toString() {
    return "[Vector: (" + this.x + ", " + this.y + ")]";
  }

  // method to normalize this vector and return a new vector
  public Vector normalizeVector() {
    double magnitude = Math.sqrt(this.x * this.x + this.y * this.y);
    if (magnitude != 0) {
      double normalizedX = this.x / magnitude;
      double normalizedY = this.y / magnitude;
      return new Vector(normalizedX, normalizedY);
    } else {
      return new Vector(0, 0);
    }
  }

  // method to calculate the magnitude of this vector
  public double getMagnitude() {
    return Math.sqrt(this.x * this.x + this.y * this.y);
  }
}
