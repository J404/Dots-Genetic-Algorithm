Population population;
ArrayList obstacles;
PVector goal;
boolean running, trackMouse;
int boxToggle;
float x, y, a, b; // coordinates for box making

void setup() {
  background(0);
  size(800, 800);
  frameRate(100);
  
  running = false;
  trackMouse = false;
  population = new Population(1000);
  goal = new PVector(width / 2, 30);
  
  boxToggle = 1;
  x = 0;
  y = 0;
  a = 0;
  b = 0;
  
  obstacles = new ArrayList<Obstacle>();
}

void draw() {
  background(255);

  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);

  text(population.gen - 32 + ' ', width - 20, 15);

  for (int i = 0; i < obstacles.size(); i++) {
    Obstacle o = (Obstacle)obstacles.get(i);
    o.show();
  }

  if (running) {
    if (population.allDead()) {
      population.calculateFitness();
      population.naturalSelection();
      population.mutate();
    } else {
      population.update();
    }
  }
  population.show();
  
  if (trackMouse) {
    fill(166, 167, 168);
    noStroke();
    rect(x, y, abs(mouseX - x), abs(mouseY - y));
  }
}

void mousePressed() {
  boxToggle++;
  if (boxToggle % 2 != 0) {
    a = mouseX;
    b = mouseY;
    Obstacle o = new Obstacle(x, y, abs(a - x), abs(b - y));
    obstacles.add(o);
    trackMouse = false;
  } else {
    x = mouseX;
    y = mouseY;
    trackMouse = true;
  }
}

void keyPressed() {
  if (key == ' ') {
    running = (running) ? false : true;
  }
  if (key == 'r') {
    population = new Population(1000);
    obstacles.clear();
  }
}
