class myVector {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }
  
  addVector(b) {
    this.x += b.x;
    this.y += b.y;
  }
  
  subtractVector(b) {
    this.x -= b.x;
    this.y -= b.y;
  }
  
  subtractVectorReturnVector(b) {
    return new myVector(this.x - b.x, this.y - b.y);
  }
  
  getX() {
    return this.x;
  }
  
  getY() {
    return this.y;
  }
  
  copyVector() {
    return new myVector(this.x, this.y);
  }
  
  setVector(x_, y_) {
    this.x = x_;
    this.y = y_;
  }
  
  scaleVector(scaler) {
    return new myVector(this.x * scaler, this.y * scaler);
  }
  
  addVectorReturnVector(b) {
    return new myVector(this.x + b.x, this.y + b.y);
  }
  
  divideVectorReturnVector(scalar) {
    if (scalar == 0) {
      return new myVector(0, 0);
    }
    return new myVector(this.x / scalar, this.y / scalar);
  }
  
  normalizeVector() {
    let magnitude = sqrt(this.x * this.x + this.y * this.y);
    if (magnitude != 0) {
      let normalizedX = this.x / magnitude;
      let normalizedY = this.y / magnitude;
      return new myVector(normalizedX, normalizedY);
    } else {
      return new myVector(0, 0);
    }
  }
  
  getMagnitude() {
    return sqrt(this.x * this.x + this.y * this.y);
  }
  
}