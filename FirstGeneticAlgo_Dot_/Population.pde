public class Population {
  public Dot[] pop;
  public float fitnessSig;
  int gen, bestDot, minStep;

  public Population(int size) {
    pop = new Dot[size];
    gen = 1;
    minStep = 1000;

    for (int i = 0; i < pop.length; i++) {
      pop[i] = new Dot();
    }
  }

  public void update() {
    for (Dot d : pop) {
      if (d.brain.step > minStep) {
        d.dead = true;
      } else
        d.update();
    }
  }

  public void show() {
    for (Dot d : pop) {
      d.show();
    }
  }

  public void calculateFitness() {
    for (Dot d : pop) {
      d.calculateFitness();
    }
  }

  public boolean allDead() {
    for (Dot d : pop) {
      if (!d.dead && !d.inGoal())
        return false;
    }
    return true;
  }

  public void naturalSelection() {
    Dot[] newDots = new Dot[pop.length];
    selectBestDot();
    calculateFitnessSum();
    
    newDots[0] = pop[bestDot].getBaby();
    newDots[0].bestDot = true;
    for (int i = 1; i < newDots.length; i++) {
      Dot parent = selectParent();
      newDots[i] = parent.getBaby();
    }

    pop = newDots.clone();
    gen++;
  }

  public void calculateFitnessSum() {
    fitnessSig = 0;
    for (Dot d : pop) {
      fitnessSig += d.fitness;
    }
  }

  public Dot selectParent() {
    float rand = random(fitnessSig);

    float runningSum = 0;

    for (Dot d : pop) {
      runningSum += d.fitness;
      if (runningSum > rand) {
        return d;
      }
    }
    return null;
  }

  public void mutate() {
    for (int i = 1; i < pop.length; i++) {
      pop[i].brain.mutate();
    }
  }
  
  public void selectBestDot() {
    float max = 0;
    int maxI = 0;
    
    for (int i = 0; i < pop.length; i++) {
      if (pop[i].fitness > max) {
        max = pop[i].fitness;
        maxI = i;
      }
    }
    
    bestDot = maxI;
    
    if (pop[bestDot].inGoal()) {
      minStep = pop[bestDot].brain.step;
      System.out.println(minStep);
    }
  }
}
