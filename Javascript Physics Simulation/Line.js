class myLine {
  constructor() {
    this.beg = new myVector(0, 0);
    this.end = new myVector(0, 0);
    
    this.drawing = false;
    this.pause = false;
  }
  
  update(currTranslate) {
    if(this.drawing) {
      let xAmt = currTranslate ? currTranslate.translation.x : 0;
      let yAmt = currTranslate ? currTranslate.translation.y : 0;
      let endX = mouseX - xAmt;
      let endY = mouseY - yAmt;
      
      this.end.setVector(endX, endY);
    }
  }
  
  show() {
    stroke(0, 0, 255) 
    fill(0, 0, 250);
    if(this.drawing) {
      ellipse(this.beg.x, this.beg.y, 5, 5,);
      line(this.beg.x, this.beg.y, this.end.x, this.end.y);
    }
    stroke(0);
  }
  
  mouse_pressed_logic(currTranslate) {
    if(mouseY > height - 200 && mouseX < 150) {
      return;
    }
    else if(!currTranslate.moving) {
      let xAmt = currTranslate.translation.x;
      let yAmt = currTranslate.translation.y;
      this.drawing = true;
      this.beg.setVector(mouseX - xAmt, mouseY - yAmt);
    }
  }
  
  mouse_released_logic() {
    this.drawing = false;
  }  
}