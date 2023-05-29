public class bounding_point {
  private boolean bounding;
  private float theta;
  private float x;
  private float y;
  private int i;
  private int j;
  public int id;
  
  public bounding_point(boolean bounding, float theta, float x, float y, int i, int j, int id) {
    this.bounding = bounding;
    this.theta = theta;
    this.x = x;
    this.y = y;
    this.i = i;
    this.j = j;
    this.id = id;
  }
  
  public boolean isBounding() {
    return bounding;
  }
  
  public float get_theta() {
    return theta;
  }
  
  public float get_x() {
    return x;
  }
  public float get_y() {
    return y;
  }
  
  public int get_i() {
    return i;
  }
  
  public int get_j() {
    return j;
  }
  
 
}
