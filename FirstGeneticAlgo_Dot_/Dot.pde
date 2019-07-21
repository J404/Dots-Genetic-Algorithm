public class Dot {
  PVector pos, vel, acc;
  public boolean dead, bestDot;
  Brain brain;
  float fitness = 0;

  public Dot() {
    pos = new PVector(width / 2, height - 30);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    dead = false;
    brain = new Brain(1000);
  }

  public void update() {
    if (!dead && !inGoal() && brain.directions.length > brain.step) {
      acc = brain.directions[brain.step];
      brain.step++;
    } else if (brain.step == brain.directions.length) {
      dead = true;
    }

    if (!dead && !inGoal()) {
      vel.add(acc);
      vel.limit(5);
      pos.add(vel);
    }


    if (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
      this.dead = true;
    }

    for (int i = 0; i < obstacles.size(); i++) {
      Obstacle o = (Obstacle)obstacles.get(i);
      if (pos.x >= o.pos.x && pos.x <= o.pos.x + o.w && pos.y > o.pos.y && pos.y < o.pos.y + o.h) {
        dead = true;
      }
    }
  }

  public boolean inGoal() {
    if (dist(pos.x, pos.y, goal.x, goal.y) < 5) {
      return true;
    } else
      return false;
  }

  public void show() {
    if (!bestDot) {
      fill(0);
      noStroke();
      ellipse(pos.x, pos.y, 5, 5);
    }
    else {
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 9, 9);
    }
  }

  public void calculateFitness() {
    if (inGoal()) {
      fitness += 1.0 / 16.0 + 10000.0 / (float)(brain.step * brain.step);
    } else {
      float distToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      fitness = 1.0 / (distToGoal * distToGoal);
    }
  }

  public Dot getBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();
    return baby;
  }
}
