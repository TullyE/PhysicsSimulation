class Button {
  constructor(label, x, y, bWidth, bHeight, bAction) {
    this.x = x;
    this.y = y;

    this.hovered = false; 
    this.clicked = false;  
    this.label = label;
    this.bWidth = bWidth;
    this.bHeight = bHeight;
    this.bColor = color(255, 255, 255);
    this.bAction = bAction;
  }
  
  touching_mouse() {
      // console.log(mouseX, mouseY);
      if ((mouseX > this.x && mouseX < this.x + this.bWidth) && (mouseY > this.y && mouseY < this.y + this.bHeight)) {
          return true;
      }
      return false;
  }
  
  button_pressed() {
    if (typeof this.bAction === "function") {
      this.bAction();
    } else {
      console.warn("bAction is not a function!");
    }
  }

  
  update() {
    if (this.touching_mouse()) {
      this.bColor = 200;      // if mouse is hovering, change color to gray
      if (this.clicked) {
        this.bColor = 100;    // if clicked, change color to darker gray
      }
    } else {
      if (this.clicked && !this.touching_mouse()) {
        this.bColor = 200;    // if clicked and mouse is not hovering, keep color gray
      } else {
        this.bColor = 255;    // otherwise, keep color white
      }
    }
  }
  
  show() {
    fill(this.bColor); 
    stroke(0);         
    rect(this.x, this.y, this.bWidth, this.bHeight);  
    fill(0);                      // set text color to black
    textAlign(CENTER, CENTER);            // center text
    text(this.label, (this.x + this.bWidth/2), (this.y + this.bHeight/2));  // display label inside the button
  }
  
  mouse_pressed_logic() {
    if (this.touching_mouse()) {
      this.clicked = true;
    }
  }
  
  mouse_released_logic() {
    if (this.touching_mouse() && this.clicked) {
      this.button_pressed();     
      this.clicked = false;     // reset clicked variable
    }
    this.clicked = false;       // reset clicked variable
  }

}