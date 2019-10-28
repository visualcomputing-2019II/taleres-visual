float rotx = PI/4;
float roty = PI/4;

void setup() {
  size(640, 360);
  noFill();
}

void draw() {
  background(0);
  translate(width/3, height/3.0);
  stroke(255);  
  drawCube();
}

void drawCube() {

  strokeWeight(1);
  beginShape(QUADS);
    if(!mousePressed){
      strokeWeight(3);
    }  
  
    vertex(0, 0);
    vertex( 0,  200);
    vertex( 200, 200);
    vertex( 200,  0);

  endShape(CLOSE);
  beginShape(QUADS);
      vertex( -40, -40);
    vertex( -40, 160);
    vertex( 160, 160);
        vertex( 160,  -40);
    endShape(CLOSE);

  beginShape(LINES);
   vertex(0, 0);
   vertex( -40, -40);

   vertex( 0,  200);
   vertex( -40, 160);

   vertex( 200, 200);
   vertex( 160, 160);

   vertex( 200,  0);
   vertex( 160,  -40);

  endShape();
}
