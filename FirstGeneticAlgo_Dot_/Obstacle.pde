public class Obstacle {
  public PVector pos;
  public float w, h;

  public Obstacle(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    this.w = w;
    this.h = h;
  }

  public void show() {
    fill(66, 92, 244);
    noStroke();
    rect(pos.x, pos.y, w, h);
  }
}
