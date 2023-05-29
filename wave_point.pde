public class wave_point {
  private float x;
  private float y;
  private float theta;
  private float step; 
  public int id;
  
  public wave_point(float x, float y, float theta, float step, int id) {
    this.x = x;
    this.y = y;
    this.theta = theta;
    this.step = step;
    this.id = id;
  }
  
  public void step_point() {
    x += step * cos(theta);
    y += step * sin(theta);
  }
  
  public void set_theta(float theta) {
    this.theta = theta;
    if ((int)(theta / TWO_PI) > 0) {
      this.theta -= (int)(theta / TWO_PI) * TWO_PI;
    }
  }
  public float get_x() {
    return x;
  }
  public float get_y() {
    return y;
  }
  public float get_theta() {
    return theta;
  }
  public String toString() {
    return  "X: " + this.x + "\tY: " + this.y + "\tTheta: " + this.theta + "rads\n";
  }
}
