import nub.timing.*;
import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

// 1. Frames' objects
Scene scene;
Node node;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;

// 2. Hints
boolean triangleHint = true;
boolean anti = true;
boolean raster = true;
boolean gridHint = true;
boolean debug = true;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P3D;




void setup() {
  //use 2^n to change the dimensions
  size(512, 512, renderer);
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fit(1);

  // not really needed here but create a spinning task
  // just to illustrate some frames.timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the frame instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask(scene) {
    @Override
    public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };

  node = new Node();
  node.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  //loadPixels();
  background(0);
  stroke(0, 255, 0);
  if (gridHint){
    scene.drawGrid(scene.radius(), (int)pow(2, n));
    //println(scene.radius());
  }
  if (triangleHint)
    drawTriangleHint();
  pushMatrix();
  pushStyle();
  scene.applyTransformation(node);
  triangleRaster();
  popStyle();
  popMatrix();
}

// Implement this function to rasterize the triangle.
// Coordinates are given in the frame system which has a dimension of 2^n
void triangleRaster() {
  // frame.location converts points from world to frame 
  // here we convert v1 to illustrate the idea
  if (debug) {
    pushStyle();
    stroke(255, 0, 0, 125);
    point(round(node.location(v1).x()), round(node.location(v1).y()));
    stroke(0, 255, 0, 125);
    point(round(node.location(v2).x()), round(node.location(v2).y()));
    stroke(0, 0, 255, 125);
    point(round(node.location(v3).x()), round(node.location(v3).y()));
    popStyle();
  }
  int squaresPerSide = (int)pow(2,n);
  //println(squaresPerSide);
  pushStyle();
  //fill(0,255,0);
  noStroke();
  boolean isClockwise = (v2.x() - v1.x())*(v3.y() - v1.y()) - (v3.x() - v1.x())*(v2.y() - v1.y()) < 0;

  
  
  
  for(int i = -squaresPerSide/2; i < squaresPerSide/2; i++)
  {
    
    for(int j = -squaresPerSide/2; j < squaresPerSide/2; j++)
    {
      //print("Edge v0: "+edge(i,j,0,1));
      if(
      ((edge(i,j,0,1) >= 0 && edge(i,j,2,0) >= 0 && edge(i,j,1,2) >= 0) && !isClockwise) ||
      ((edge(i,j,0,1) < 0 && edge(i,j,2,0) < 0 && edge(i,j,1,2) < 0) && isClockwise)) 
      {
        float barCoords[] = barycentric(i,j);
        
        
        // Matriz que contiene los colores del cuadro evaluado y los ocho cuadros adyacentes
        
        int antialiasing[][] = new int[9][3];
        
        
        // La funcion defColor determina cuál es el color del cuadro adyacente usando 
        //las coordenadas baricéntricas si el cuadro está dentro del triángulo. Si el 
        //cuadro no está dentro del triángulo, se supone negro.
        
        antialiasing [0] = defColor(i+1,j+1,isClockwise);
        antialiasing [1] = defColor(i+1,j,isClockwise);
        antialiasing [2] = defColor(i+1,j-1,isClockwise);
        antialiasing [3] = defColor(i,j+1,isClockwise);
        antialiasing [4] = defColor(i,j,isClockwise);
        antialiasing [5] = defColor(i,j-1,isClockwise);
        antialiasing [6] = defColor(i-1,j+1,isClockwise);
        antialiasing [7] = defColor(i-1,j,isClockwise);
        antialiasing [8] = defColor(i-1,j-1,isClockwise);

        
        
        
        

        
        
        
        
        int colors[] = new int[3];
        for(int k=0; k<3; k++) colors[k] = (int)(barCoords[k]*256);
        
        // Se usan los colores del antialiasing, cuando se presiona la tecla "a"
        // La técnica es el promedio de los colores de los 9 cuadros mencionados
        
        if (anti){
          for(int k=0; k<3; k++){
            int sum = 0;
            for(int z=0; z<=8; z++) {
              sum = sum + antialiasing [z][k];
            }
            colors[k]=(int) (sum/8);
          }
        }
        
        // Si se oprime la tecla "s" los cuadros dentro del triángulo, son blancos.
        
        if (raster){
          colors[0] = 255;
          colors[2] = 255;
          colors[1] = 255;
        }
        
        
        
        
        fill(colors[0],colors[1],colors[2]);
        rect(i,j,1,1);
        
        
        
        
        
        
        

        
        
        

        
        
      }
      
     
      
    }
    

      
    }
    
    
    
  //updatePixels();  
  popStyle();
}

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
}

void drawTriangleHint() {
  pushStyle();
  noFill();
  strokeWeight(2);
  stroke(255, 0, 0);
  triangle(v1.x(), v1.y(), v2.x(), v2.y(), v3.x(), v3.y());
  strokeWeight(5);
  stroke(0, 255, 255);
  point(v1.x(), v1.y());
  point(v2.x(), v2.y());
  point(v3.x(), v3.y());
  popStyle();
}

void keyPressed() {
  if (key == 'a'){
    anti = !anti;
  }
  if (key == 's'){
    raster = !raster;
  }
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    node.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    node.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run(20);
  if (key == 'y')
    yDirection = !yDirection;
}

// Fab(p)
float edge(int px, int py, int a, int b)
{
  int scale = (int)pow(2,n);
  //px = (px+scale/2)*width/(scale);
  //py = (py+scale/2)*height/(scale);
  float v[][] = new float[3][2];
  v[0][0] = v1.x()*scale/width;
  v[0][1] = v1.y()*scale/height;
  v[1][0] = v2.x()*scale/width;
  v[1][1] = v2.y()*scale/height;
  v[2][0] = v3.x()*scale/width;
  v[2][1] = v3.y()*scale/height;
  //println("scale: " + scale + ", px = "+px+", py = "+py+", a[0]="+v[a][0]+", b[0]="+v[a][1]);
  return (v[a][1] - v[b][1])*px + ((v[b][0]) - v[a][0])*py + (v[a][0]*v[b][1] - v[a][1]*v[b][0]);
}

float[] barycentric(int px, int py)
{
  float p0 = Math.abs(edge(px, py, 1, 2));
  float p1 = Math.abs(edge(px, py, 2, 0));
  float p2 = Math.abs(edge(px, py, 0, 1));
  float area = (p0 + p1 + p2);
  return new float[]{p0/area, p1/area, p2/area};
}
int [] defColor(int i, int j, boolean isClockwise)
{
  
  if(
    ((edge(i,j,0,1) >= 0 && edge(i,j,2,0) >= 0 && edge(i,j,1,2) >= 0) && !isClockwise) ||
    ((edge(i,j,0,1) < 0 && edge(i,j,2,0) < 0 && edge(i,j,1,2) < 0) && isClockwise)) 
  {
    float barCoords[] = barycentric(i,j);
    int colors[] = new int[3];
    for(int k=0; k<3; k++) colors[k] = (int)(barCoords[k]*256); 
    return new int [] {colors[0],colors[1],colors[2]};
    
  }else{
    return new int [] {0,0,0};
  }
  

}
