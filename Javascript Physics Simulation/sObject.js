class sObject {
  constructor(location, velocity, acceleration, mass) {
    this.location = location;
    this.velocity = velocity;
    this.acceleration = acceleration;
    this.mass = mass;
    
    this.history = [];
    
    this.running_vector = new myVector(0, 0)
    
    this.checked = false;
    this.toRemove = false;
    this.showTrail = false;
  
    this.c = color(0, 0, 0);
  }
  
  move(showTrails) {
    this.showTrail = showTrails
    if(this.showTrail) {
      this.history.push(this.location.copyVector())
    }
    else {
      this.history = []
    }
    this.velocity.addVector(this.acceleration);
    this.location.addVector(this.velocity);
  }

  getColor() {

    let white_ = [255, 255, 255];  
    let orange_ = [55, 165, 0]; 
    let red_ = [255,0, 0] 
    if (this.mass <= 1000000) {
      let ratio = Math.log10(this.mass) / Math.log10(1000000);  
      let color_ = [0, 0, 0];
      for (let i = 0; i < 3; i++) {
        color_[i] =(white_[i] + (orange_[i] - white_[i]) * ratio * ratio); 
      }
      return color(color_[0], color_[1], color_[2]);
    } else {
      let ratio = Math.log10(this.mass - 1000000) / Math.log10(9000000); 
      let color_ = [0, 0, 0];
      for (let i = 0; i < 3; i++) {
        color_[i] = (orange_[i] + (red_[i] - orange_[i]) * ratio * ratio);  
      }
      return color(color_[0], color_[1], color_[2]);
    }
  }
  
  drawTrail() {
    if(this.showTrail) {
      noFill();
      beginShape();
      stroke(this.c);
      this.history.forEach((v) => {
        vertex(v.x, v.y);
      });
      endShape();
    }
  }
  
  show() {
    this.drawTrail();
    this.c = this.getColor(this.mass);
    fill(this.c);
    stroke(this.c);
    ellipse(this.location.x, this.location.y, max(log(this.mass), 2), max(log(this.mass), 2))
    
  }
}

