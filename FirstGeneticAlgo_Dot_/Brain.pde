public class Brain {
  public PVector[] directions;
  public int step = 0;

  public Brain(int size) {
    directions = new PVector[size];
    randomize();
  }

  public void randomize() {
    for (int i = 0; i < directions.length; i++) {
      float randAngle = random(2*PI);
      directions[i] = PVector.fromAngle(randAngle);
    }
  }

  public Brain clone() {
    Brain clone = new Brain(directions.length);

    for (int i = 0; i < directions.length; i++) {
      clone.directions[i] = directions[i].copy();
    }

    return clone;
  }

  public void mutate() {
    float mutationRate = 0.01;

    for (int i = 0; i < directions.length; i++) {
      float rand = random(1);
      if (rand < mutationRate) {
        float randAngle = random(2*PI);
        directions[i] = PVector.fromAngle(randAngle);
      }
    }
  }
}
