/**
* simulates particles in outerspace
* you're able to move the screen around
* spawn new particles by clicking the mouse
* a line to set the new velocity of particles
* you can change the mass of particles that are being placed
* paths are shown for objects
*
* created by TullyE March 2023
* last updated April 10 2023
*/

//Variables
public static final double G = 0.000002; //Gravitational Constant
public int currMass = 5000000; //Mass of the particle that will be placed
public boolean showTrails = true; //Whether or not trails should be drawn
public boolean movingScreen = false; //Whether the user is translating the screen
public Line l; //Mouse guidelines
public Translate t; //Amount the screen has been translated
public Hud hud; //Display information to the user
public ArrayList<sObject> particles = new ArrayList<sObject>(); //Where the particles are stored
public ArrayList<Vector> paths = new ArrayList<Vector>(); //the paths of all the particles

/** 
* initializes values for each of the variables
* sets the framerate and makes the window resizeable
* 
* @param none
* @return none
*/
void setup() {
  surface.setResizable(true);
  frameRate(60);
  size(500, 500);
  t = new Translate();
  l = new Line();
  hud = new Hud();
}

/**
* sets the background to black
* translates the screen apprpriately 
* draws any lines according to the line variable
* draws and calculates the behavior for all the particles
* displays the HUD
* 
* @param none
* @return none
*/
void draw() {
  background(0);
  pushMatrix();
  translate((float) t.translation.x, (float) t.translation.y);
  stroke(255, 0, 0);
  l.update();
  l.show();
  t.update();
  for (int i = 0; i < particles.size(); i++) {
    calculateForces();
    particles.get(i).show();
    particles.get(i).move();
    particles.get(i).runningVector.setVector(0, 0);
    groupAsteroids();
  }
  popMatrix();
  hud.update();
  hud.show();
}

/**
* handles any key pressed logic
* 
* @param none
* @return none
*/
void keyPressed() {
  t.keyPressedLogic(keyCode);
  l.keyPressedLogic(keyCode);
}

/**
* handles any key released logic
* 
* @param none
* @return none
*/
void keyReleased() {
  t.keyReleasedLogic(keyCode);
}

/**
* handles any mouse clicked logic
* 
* @param none
* @return none
*/
void mousePressed() {
  hud.mousePressedLogic();
  t.mousePressedLogic();
  l.mousePressedLogic();
}

/**
* handles any mouse released logic
* 
* @param none
* @return none
*/
void mouseReleased() {
  hud.mouseReleasedLogic();
  t.mouseReleasedLogic();
  if (l.drawing) {
    spawnNewParticle();
  }

  l.mouseReleasedLogic();
}

/**
* adds a new particle to the screen according to the vector the user set using the line
* 
* @param none
* @return none
*/
public void spawnNewParticle() {
  particles.add(new sObject(new Vector(l.beg.x, l.beg.y), new Vector(-1 * (l.beg.x - l.end.x) / 200, -1 * (l.beg.y - l.end.y) / 200), new Vector(0, 0), currMass));
}


/**
* calculates the forces each object experiences due to the other objects
* 
* @param none
* @return none
*/
public void calculateForces() {
  for (int i = 0; i < particles.size(); i ++) {
    sObject obj1 = particles.get(i);
    for (int j = i+1; j < particles.size(); j ++) {
      sObject obj2 = particles.get(j);
      double distance = dist((float) obj1.location.x, (float) obj1.location.y, (float) obj2.location.x, (float) obj2.location.y);
      double theta = Math.atan2(obj2.location.y - obj1.location.y, obj2.location.x - obj1.location.x);
      double F = (G * (obj1.mass * obj2.mass)) / Math.pow(distance, 2);
      double fX = F * Math.cos(theta);
      double fY = F * Math.sin(theta);
      double aX1 = fX / obj1.mass;
      double aY1 = fY / obj1.mass;
      double aX2 = -1 * fX / obj2.mass;
      double aY2 = -1 * fY / obj2.mass;
      
      obj1.runningVector.x += aX1;
      obj1.runningVector.y += aY1;
      obj2.runningVector.x += aX2;
      obj2.runningVector.y += aY2;
    }
    obj1.acceleration = obj1.runningVector.cloneVector();
  }
}

/**
* this function combines two particles that are touching eachother
* combine particles have an appropriate mass velocity and acceleration
* momentum is conserved (for the most part) 
* !! this could be rewritten later or checked for errors in the calculations
* 
* @param none
* @return none
*/
public void groupAsteroids() {
  for (int i = particles.size() - 1; i >= 0; i--) {
    sObject obj1 = particles.get(i);
    for (int j = i - 1; j >= 0; j--) {
      sObject obj2 = particles.get(j);
      double distance = Math.sqrt(Math.pow(obj1.location.x - obj2.location.x, 2) + Math.pow(obj1.location.y - obj2.location.y, 2));
      double radiusTotal = (Math.max(Math.log(obj1.mass), 2)/2) + (Math.max(Math.log(obj2.mass), 2)/2);
      if (distance < radiusTotal && obj1 != obj2) {
        Vector newLocation = obj1.mass == obj2.mass ? new Vector((obj1.location.x + obj2.location.x) / 2, (obj1.location.y + obj2.location.y) / 2) : obj2.mass > obj1.mass ? obj2.location : obj1.location;
        double newMass = obj1.mass + obj2.mass;
        Vector p1 = obj1.velocity.scaleVector(obj1.mass);
        Vector p2 = obj2.velocity.scaleVector(obj2.mass);
        Vector pTotal = p1.addVectorReturnVector(p2);
        Vector newVelocity = pTotal.divideVectorReturnVector(newMass);
        if(Math.abs(newVelocity.x) < 0.04) {
          newVelocity.x = 0;
        }
        if(Math.abs(newVelocity.y) < 0.04) {
          newVelocity.y = 0;
        }
        Vector newAcceleration = new Vector(0, 0);
        particles.remove(obj1);
        particles.remove(obj2);
        particles.add(new sObject(newLocation, newVelocity, newAcceleration, newMass));
      }
    }
  }
}
