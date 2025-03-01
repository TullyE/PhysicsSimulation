class myTranslate {
  constructor() {
    this.translation = new myVector(width/2, height/2);
    this.mouseStart = new myVector(0, 0);
    this.mouseEnd = new myVector(0, 0);
    this.mouseChange = new myVector(0, 0);
    this.translationStart = new myVector(0, 0);
    this.moving = false;
    
    this.moveKey = false;
    this.isMousePressed = false;
  }
  
  update() {
    this.mouseEnd.setVector(mouseX, mouseY);
    if(this.moving) {
      this.mouseChange = new myVector(this.mouseStart.x - this.mouseEnd.x, this.mouseStart.y - this.mouseEnd.y);
      this.translation.setVector(this.translationStart.x - this.mouseChange.x, this.translationStart.y - this.mouseChange.y);
    }
  }
  
  mouse_pressed_logic(currTranslation) {
    if(keyIsPressed && keyCode == 16 && mouseButton === LEFT) {
      if(!this.moving) {
        this.moving = true;
        this.startMoving(currTranslation);
      }
    }
  }
  
  mouse_released_logic() {
    this.moving = false;
  }
  
  key_pressed_logic(kCode, currTranslation, currLine) {
    if(currLine.drawing) {return}
    if (mouseIsPressed && mouseButton === LEFT) {
        if(!this.moving) {
          if(kCode == 16) {
            this.moving = true;
            this.startMoving(currTranslation)
          }
        }
      }
  }
  
  key_released_logic(kCode) {
    this.moving = false;
  }
  
  startMoving(currTranslation) {
    this.mouseStart.setVector(mouseX, mouseY);
    this.translationStart.setVector(currTranslation.translation.getX(), currTranslation.translation.getY());
  }
}