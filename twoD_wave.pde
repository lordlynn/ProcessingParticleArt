 

double x_min;
double x_max;
double y_min;
double y_max;
double x_scale;
double y_scale;
int x_offset;
int y_offset;
float step;
int step_scalar = 1;

int particles = 3500;
wave_point point_cloud[] = new wave_point[particles];
bounding_point bounding_shape[][];

void setup() {
  background(0);
  size(900, 900);
  x_min = -1;
  x_max = 1;
  y_min = -1;
  y_max = 1;
  
  bounding_shape = new bounding_point[this.width][this.height];
  
  x_scale = this.width / (x_max - x_min);
  y_scale = this.height / (y_max - y_min);
  
  x_offset = this.width / 2;
  y_offset = this.width / 2;
  
  step = sqrt(pow((float)x_scale, -2.0) + pow((float)y_scale, -2.0)) * step_scalar;        // Step size equal to the magnitude of moving 1 pixel in x and y
  
  create_pulse();
  
  setup_bounding_rectangle(100, 100, 800, 800);
  //setup_bounding_triag();

}


void draw() {
  int x, y;
  background(0);
  
 
  stroke(255, 255, 255);
  for (int i = 0; i < this.width; i++) {
    for (int j = 0; j < this.height; j++) {
      if (bounding_shape[i][j].isBounding()) {
        point(i, j);
      }
    }
  }
  


  for (int i = 0; i < particles; i++) {
    stroke(255, 75, 200);
    fill(255, 75, 200);
    x = x_offset + (int)(x_scale * point_cloud[i].get_x());
    y = y_offset - (int)(y_scale * point_cloud[i].get_y());
    if (x <= 0 || x >= 899) {
      print("Particle [" + i + "] is out of bounds\n");
      continue;
    }
    else if (y <= 0 || y >= 899) {
      print("Particle [" + i + "] is out of bounds\n");
      continue;
    }
    
    
    if (bounding_shape[x][y].isBounding())
      calculate_reflection(i, bounding_shape[x][y].get_i(), bounding_shape[x][y].get_j());
      
    //else if (bounding_shape[x-1][y].isBounding())
    //  calculate_reflection(i, bounding_shape[x-1][y].get_i(), bounding_shape[x-1][y].get_j());
      
    //else if (bounding_shape[x][y-1].isBounding())
    //  calculate_reflection(i, bounding_shape[x][y-1].get_i(), bounding_shape[x][y-1].get_j());
      
    else if (bounding_shape[x-1][y-1].isBounding()) 
      calculate_reflection(i, bounding_shape[x-1][y-1].get_i(), bounding_shape[x-1][y-1].get_j());
      
    //else if (bounding_shape[x+1][y].isBounding()) 
    //  calculate_reflection(i, bounding_shape[x+1][y].get_i(), bounding_shape[x+1][y].get_j());
      
    //else if (bounding_shape[x][y+1].isBounding())
    //  calculate_reflection(i, bounding_shape[x][y+1].get_i(), bounding_shape[x][y+1].get_j());
      
    else if (bounding_shape[x+1][y+1].isBounding()) 
      calculate_reflection(i, bounding_shape[x+1][y+1].get_i(), bounding_shape[x+1][y+1].get_j());
      
    //else if (bounding_shape[x-1][y+1].isBounding())
    //  calculate_reflection(i, bounding_shape[x-1][y+1].get_i(), bounding_shape[x-1][y+1].get_j());
      
    //else if (bounding_shape[x+1][y-1].isBounding())
    //  calculate_reflection(i, bounding_shape[x+1][y-1].get_i(), bounding_shape[x+1][y-1].get_j());
          
      
    
    circle(x, y, 4);
    point_cloud[i].step_point();
    
    
  
  }
  delay(5);
}



void setup_bounding_rectangle(int P1x, int P1y, int P2x, int P2y) {
  float x, y, x1, x2, x3, y1, y2, y3;
  
  int xMin = P1x;
  int xMax = P2x;
  int yMin = P1y;
  int yMax = P2y;
  
  int id = 0;
  float theta = 0.0;
  
  // Instatiate
  for (int i = 0; i < this.width; i++) {
    x = (float)((i - x_offset) * x_scale);
    for (int j = 0; j < this.height; j++) {
      y = (float)((j - y_offset) * y_scale);
      
      bounding_shape[i][j] = new bounding_point(false, 0.0, x, y, i, j, 0);
    }
  }
  
  // Initialize Top
  for (int i = xMin-1; i <= xMax+1; i++) {
    x = (float)((i - x_offset) * x_scale);
    
    y1 = (float)((xMin - 1 - y_offset) * y_scale);
    y2 = (float)((xMin - y_offset) * y_scale);
    y3 = (float)((xMin + 1 - y_offset) * y_scale);
    
    if (i <= xMin+1)
      theta = PI / 4.0;
    else if (i >= xMax-1)
      theta = -PI / 4.0;
    else
      theta = 0.0;
    
    bounding_shape[i][xMin - 1] = new bounding_point(true, theta, x, y1, i, xMin - 1, id++);
    bounding_shape[i][xMin] = new bounding_point(true, theta, x, y2, i, xMin, id++);
    bounding_shape[i][xMin + 1] = new bounding_point(true, theta, x, y3, i, xMin + 1, id++);
  }
  
  // Initialize Bottom
  for (int i = xMin-1; i <= xMax+1; i++) {
    x = (float)((i - x_offset) * x_scale);
    
    y1 = (float)((xMax - 1 - y_offset) * y_scale);
    y2 = (float)((xMax - y_offset) * y_scale);
    y3 = (float)((xMax + 1 - y_offset) * y_scale);
    
    if (i <= xMin+1)
      theta = -PI / 4.0;
    else if (i >= xMax-1)
      theta = PI / 4.0;
    else
      theta = 0.0;
    
    bounding_shape[i][yMax - 1] = new bounding_point(true, theta, x, y1, i, yMax - 1, id++);
    bounding_shape[i][yMax] = new bounding_point(true, theta, x, y2, i, yMax, id++);
    bounding_shape[i][yMax + 1] = new bounding_point(true, theta, x, y3, i, yMax + 1, id++);
  }
  
  
  // Initialize Left
   for (int i = yMin-1; i <= yMax+1; i++) {
    y = (float)((i - y_offset) * y_scale);
    
    x1 = (float)((yMin - 1 - x_offset) * x_scale);
    x2 = (float)((yMin - x_offset) * x_scale);
    x3 = (float)((yMin + 1 - x_offset) * x_scale);
    
    if (i <= yMin+1)
      theta = PI / 4.0;
    else if (i >= yMax-1)
      theta = -PI / 4.0;
    else
      theta = PI / 2;
    
    bounding_shape[yMin - 1][i] = new bounding_point(true, theta, x1, y, yMin - 1, i, id++); //<>//
    bounding_shape[yMin][i] = new bounding_point(true, theta, x2, y, yMin, i, id++);
    bounding_shape[yMin + 1][i] = new bounding_point(true, theta, x3, y, yMin + 1, i, id++);
  }
  
  
  // Initialize Right
  for (int i = yMin-1; i <= yMax+1; i++) {
    y = (float)((i - y_offset) * y_scale);
    
    x1 = (float)((yMax - 1 - x_offset) * x_scale);
    x2 = (float)((yMax - x_offset) * x_scale);
    x3 = (float)((yMax + 1 - x_offset) * x_scale);
    
     if (i <= yMin+1)
      theta = -PI / 4.0;
    else if (i >= yMax-1)
      theta = PI / 4.0;
    else
      theta = PI / 2;
    
    bounding_shape[xMax - 1][i] = new bounding_point(true, theta, x1, y, xMax - 1, i, id++);
    bounding_shape[xMax][i] = new bounding_point(true, theta, x2, y, xMax, i, id++);
    bounding_shape[xMax + 1][i] = new bounding_point(true, theta, x3, y, xMax + 1, i, id++);
  }
  
}


void setup_bounding_triag() {
  float x, y;
    
  int id = 0;
  //for (int i = 0; i < this.width; i++) {
  //  x = (float)((i - x_offset) * x_scale);
  //  for (int j = 0; j < this.height; j++) {
  //    y = (float)((j - y_offset) * y_scale);
  //    bounding_shape[i][j] = new bounding_point(true, PI / 2.0, x, y, i, j);
  //  }
  //}
  
  
  //for (int i = 200; i < this.width - 200; i++) {
  //  x = (float)((i - x_offset) * x_scale);
  //  for (int j = 200; j < this.height - 200; j++) {
  //    y = (float)((j - y_offset) * y_scale);
  //    bounding_shape[i][j] = new bounding_point(false, 0.0, x, y, i, j);
  //  }
  //}
  
  for (int i = 0; i < this.width; i++) {
    x = (float)((i - x_offset) * x_scale);
    for (int j = 0; j < this.height; j++) {
      y = (float)((j - y_offset) * y_scale);
      bounding_shape[i][j] = new bounding_point(false, 0.0, x, y, i, j, id++);
    }
  }

  for (int i = 100; i < this.width - 100; i++) {
    x = (float)((i - x_offset) * x_scale);
    y = (float)((100 - y_offset) * y_scale);
    bounding_shape[i][100] = new bounding_point(true, 0.0, x, y, i, 100, id++);
  }
  
  for (int i = 100; i < this.width - 100; i++) {
    x = (float)((i - x_offset) * x_scale);
    y = (float)((800 - y_offset) * y_scale);
    bounding_shape[i][800] = new bounding_point(true, 0.0, x, y, i, 800, id++);
  }
  
  for (int i = 100; i < this.height - 100; i++) {
    x = (float)((100 - x_offset) * x_scale);
    y = (float)((i - y_offset) * y_scale);
    bounding_shape[100][i] = new bounding_point(true, PI / 2.0, x, y, 100, i, id++);
  }
  
  for (int i = 100; i < this.height - 100; i++) {
    x = (float)((800 - x_offset) * x_scale);
    y = (float)((i - y_offset) * y_scale);
    bounding_shape[800][i] = new bounding_point(true, PI / 2.0, x, y, 800, i, id++);
  }




  for (int i = 250; i < this.width - 250; i++) {
    x = (float)((i - x_offset) * x_scale);
    y = (float)((200 - y_offset) * y_scale);
    bounding_shape[i][200] = new bounding_point(true, 0.0, x, y, i, 200, id++);
  }
  
  for (int i = 250; i < this.width - 250; i++) {
    x = (float)((i - x_offset) * x_scale);
    y = (float)((700 - y_offset) * y_scale);
    bounding_shape[i][700] = new bounding_point(true, 0.0, x, y, i, 700, id++);
  }
  
  for (int i = 250; i < this.height - 250; i++) {
    x = (float)((200 - x_offset) * x_scale);
    y = (float)((i - y_offset) * y_scale);
    bounding_shape[200][i] = new bounding_point(true, PI / 2.0, x, y, 200, i, id++);
  }
  
  for (int i = 250; i < this.height - 250; i++) {
    x = (float)((700 - x_offset) * x_scale);
    y = (float)((i - y_offset) * y_scale);
    bounding_shape[700][i] = new bounding_point(true, PI / 2.0, x, y, 700, i, id++);
  }
  
}


void calculate_reflection(int i, int x, int y) {
  float surface;
  float normal;
  float theta = point_cloud[i].get_theta();

  surface = bounding_shape[x][y].get_theta();

  normal = PI / 2.0 - surface;


  float reflect = PI - theta - normal;
  float relative = PI / 2.0 - reflect - surface;
  
  //if (i == 375 || i == 125 || i == 0) {
  //  x = x_offset + (int)(x_scale * point_cloud[i].get_x());
  //  y = y_offset - (int)(y_scale * point_cloud[i].get_y());
  //  print("Pre reflection [" + i + "]: X - " + x + "\tY - " + y + "\ttheta: " + surface + "\n");
  //}

    
  point_cloud[i].set_theta(-1.0 * relative);
  point_cloud[i].step_point();
  
  //if (i == 375 || i == 125 || i == 0) {
  //  x = x_offset + (int)(x_scale * point_cloud[i].get_x());
  //  y = y_offset - (int)(y_scale * point_cloud[i].get_y());
  //  print("Post reflection [" + i + "]: X - " + x + "\tY - " + y  + "\ttheta: " + surface + "\n");
  //}
}






void create_pulse() {
  int id = 0;
  for (int i = 0; i < particles; i++) {
    point_cloud[i] = new wave_point(0, 0, i / (float)particles * TWO_PI, step, id++); 
    
    
    
    //if (i == 375) 
    //  point_cloud[0] = new wave_point(0, 0, i / (float)particles * TWO_PI, step, id++); 
      
    //if (i == 375 || i == 125 || i == 625) {
    //  print(point_cloud[0]);
    //}
    
  }
  
}
