class HUD {
  constructor(curr_mass, show_trails, particle_num) {
    textAlign(CENTER, CENTER); 
    this.fontSize = 15;
    this.font = textFont("Arial-ItalicMT", this.fontSize)
    this.y = 20;
   
    this.particle_num = particle_num;
    this.curr_mass = curr_mass;
    this.show_trails = show_trails;
    this.clear_particles = false;
    this.gen_protodisk = false;
    
    this.buttons = [];
    this.numsYButtonArr = [10, 9, 8, 7, 6, 5, 5, 4, 1];
    this.buttons.push(new Button("Tiny", 0, height - (10 * this.y), 50, 20, () => this.curr_mass = 1)); // 0
    this.buttons.push(new Button("Small", 0, height - (9 * this.y), 50, 20, () => this.curr_mass = 1000)); // 1
    this.buttons.push(new Button("Medium", 0, height - (8 * this.y), 50, 20, () => this.curr_mass = 10000)); // 2
    this.buttons.push(new Button("Large", 0, height - (7 * this.y), 50, 20, () => this.curr_mass = 100000)); // 3
    this.buttons.push(new Button("Huge", 0, height - (6 * this.y), 50, 20, () => this.curr_mass = 1000000)); // 4
    this.buttons.push(new Button("OMFG", 0, height - (5 * this.y), 50, 20, () => this.curr_mass = 10000000)); // 5
    this.buttons.push(new Button("Clear", 100, height - (5 * this.y), 50, 20,() => { this.clear_particles = true})); // 6
    this.buttons.push(new Button("Paths", 100, height - (4 * this.y), 50, 20, () => {this.show_trails = !this.show_trails})); // 8
    this.buttons.push(new Button("Generate proto disk (slow start)", 0, height - (1 * this.y), 200, 20, () => this.gen_protodisk = true)); // 7
  }
  
  update(particleNum) {
    this.particle_num = particleNum;
    for (let i = 0; i < this.buttons.length; i ++) {
      this.buttons[i].y = height - this.numsYButtonArr[i] * 20;
    }
  }
  
  show() {
    textAlign(CENTER, CENTER); 
    textFont(this.font);
    textSize(this.fontSize);
    
    // Update and show each button in the ArrayList
    this.buttons.forEach((button) => {
      button.update();
      button.show();
    });

    // Set the fill color to white and the text alignment to left, and display some informational text
    fill(255);
    textAlign(LEFT);
    text("Not to physical scale. Gravitational constant is 1. Particle radius is log of mass. Integration is θ(n^2)Euler.", 0, 10);
    // Display the current mass and number of particles
    text("Mass: " + this.curr_mass, 0, height - (10.5 * 20));
    text("Particle Num: " + this.particle_num, 0, height - (3 * 20));
    let show_trails_text = this.show_trails ? "[✓]" : "[   ] ";
    text(show_trails_text, 155, height - (3.3 * 20));
  }
  
  get_selected_mass() {
    return this.curr_mass;
  }
  
  trails_toggle() {
    return this.show_trails;
  }
  
  need_to_clear_particles() {
    return this.clear_particles
  }
  
  reset_clear_button() {
    this.clear_particles = false;
  }
  
  need_to_gen_protodisk() {
    return this.gen_protodisk
  }
  
  reset_protodisk() {
    this.gen_protodisk = false;
  }
  
  
  mouse_pressed_logic() {
    this.buttons.forEach((button) => {
      button.mouse_pressed_logic();
    });
  }

  // Define a method to handle logic when the mouse is released
  mouse_released_logic() {
    this.buttons.forEach((button) => {
      button.mouse_released_logic();
    });
  }
  
}