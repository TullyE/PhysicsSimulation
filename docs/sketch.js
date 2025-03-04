let G = 0.000002;
let hud, trailLine;
let curr_mass = 1;
let particles = [];
let t;


let show_trails = true;

function setup() {
  createCanvas(windowWidth, windowHeight);
  frameRate(60);
  window.focus();
  t = new myTranslate();
  hud = new HUD(curr_mass, show_trails, particles.length);
  trailLine = new myLine();
  
}

function keyPressed(e) {
  t.key_pressed_logic(keyCode, t, trailLine);
}

function keyReleased(e) {
  t.key_released_logic(keyCode);
}

function mousePressed(e) {
  hud.mouse_pressed_logic();
  t.mouse_pressed_logic(t);
  trailLine.mouse_pressed_logic(t);
}

function mouseReleased(e) {
  hud.mouse_released_logic();
  
  t.mouse_released_logic();
  
  if(trailLine.drawing) {
    spawnNewParticle();
  }
  trailLine.mouse_released_logic();
}

function draw() {
  background(0);
  push();
  translate(t.translation.x, t.translation.y);
  trailLine.update(t);
  trailLine.show();
  t.update();
  groupAsteroids();
  calculateForces();
  for(let i = 0; i < particles.length; i++) {
    particles[i].show();
    particles[i].move(show_trails);
    particles[i].running_vector.setVector(0, 0);  
  }
  
  pop();
  hud.update(particles.length);
  curr_mass = hud.get_selected_mass();
  show_trails = hud.trails_toggle();
  hud.show();
  if(hud.need_to_clear_particles()) {
    hud.reset_clear_button();
    particles = []
    
  }
  if(hud.need_to_gen_protodisk()) {
    let protodisk = generateProtodisk(50, 800 / 2, min(width / 2, height / 2), 100, 100000);
    particles = particles.concat(protodisk);
    hud.reset_protodisk();
  }
} 





function windowResized() {
	resizeCanvas(windowWidth, windowHeight);
}

function spawnNewParticle() {
  particles.push(new sObject(new myVector(trailLine.beg.x, trailLine.beg.y), new myVector(-1 * (trailLine.beg.x - trailLine.end.x) / 200, -1 * (trailLine.beg.y - trailLine.end.y) / 200), new myVector(0, 0), curr_mass));
}


function calculateForces() {
  let obj1, obj2, theta, F, fX, fY, aX1, aY1, aX2, aY2;
  for (let i = 0; i < particles.length; i ++) {
    obj1 = particles[i];
    for (let j = i+1; j < particles.length; j ++) {
      obj2 = particles[j];
      distance = dist(obj1.location.x, obj1.location.y, obj2.location.x, obj2.location.y);
      theta = Math.atan2(obj2.location.y - obj1.location.y, obj2.location.x - obj1.location.x);
      F = (G * (obj1.mass * obj2.mass)) / pow(distance, 2);
      fX = F * cos(theta);
      fY = F * sin(theta);
      aX1 = fX / obj1.mass;
      aY1 = fY / obj1.mass;
      aX2 = -1 * fX / obj2.mass;
      aY2 = -1 * fY / obj2.mass;
      
      obj1.running_vector.x += aX1;
      obj1.running_vector.y += aY1;
      obj2.running_vector.x += aX2;
      obj2.running_vector.y += aY2;
    }
    obj1.acceleration = obj1.running_vector.copyVector();
  }
}

function groupAsteroids() {
  let obj1, obj2, distance, radiusTotal, newLocation, newMass, p1, p2, pTotal, newVelocity, newAcceleration, idx;
  for (let i = particles.length - 1; i >= 0; i--) {
    obj1 = particles[i];
    for (let j = i - 1; j >= 0; j--) {
      obj2 = particles[j];
      distance = sqrt(pow(obj1.location.x - obj2.location.x, 2) + pow(obj1.location.y - obj2.location.y, 2));
      radiusTotal = (max(log(obj1.mass), 2)/2) + (max(log(obj2.mass), 2)/2);
      if (distance < radiusTotal && obj1 != obj2) {
        newLocation = obj1.mass == obj2.mass ? new myVector((obj1.location.x + obj2.location.x) / 2, (obj1.location.y + obj2.location.y) / 2) : obj2.mass > obj1.mass ? obj2.location : obj1.location;
        newMass = obj1.mass + obj2.mass;
        p1 = obj1.velocity.scaleVector(obj1.mass);
        p2 = obj2.velocity.scaleVector(obj2.mass);
        pTotal = p1.addVectorReturnVector(p2);
        newVelocity = pTotal.divideVectorReturnVector(newMass);
        if(abs(newVelocity.x) < 0.04) {
          newVelocity.x = 0;
        }
        if(abs(newVelocity.y) < 0.04) {
          newVelocity.y = 0;
        }
        newAcceleration = new myVector(0, 0);
        
        idx = particles.indexOf(obj1);
        if (idx !== -1) {
          particles.splice(idx, 1);
        }
        
        idx = particles.indexOf(obj2);
        if (idx !== -1) {
          particles.splice(idx, 1);
        }
        
        particles.push(new sObject(newLocation, newVelocity, newAcceleration, newMass));
      }
    }
  }
}


function generateProtodisk(numParticles, centralMass, diskRadius, minMass, maxMass) {
  let particles = [];
  
  for (let i = 0; i < numParticles; i++) {
    let r = diskRadius * Math.sqrt(Math.random()); // More particles near center
    let theta = Math.random() * TWO_PI; // Random angle in disk

    let x = r * Math.cos(theta) - t.translation.x + width / 2; 
    let y = r * Math.sin(theta) - t.translation.y + height / 2;
    let location = new myVector(x, y);
    
    let mass = minMass * Math.pow(maxMass / minMass, Math.random()); // Smooth variation

    let vMag = Math.sqrt(centralMass / r); // Simplified Keplerian motion
    let velocity = new myVector(-vMag * Math.sin(theta), vMag * Math.cos(theta)); // Tangential velocity
    
    velocity.addVector(new myVector((Math.random() - 0.5) * 0.1 * vMag, (Math.random() - 0.5) * 0.1 * vMag));
    
    let acceleration = new myVector(-centralMass * x / Math.pow(r, 3), -centralMass * y / Math.pow(r, 3));

    let particle = new sObject(location, velocity, acceleration, mass);
    particles.push(particle);
  }

  return particles;
}
