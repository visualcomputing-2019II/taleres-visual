PShape g;
PShape b;
PShape r;
int x=0;
int y=0;
int z=255;
void setup() {
  size(350,300);
  
}
void draw() {
g = createShape();
  g.beginShape();
  g.vertex(140, 20);
  g.vertex(180, 20);
  g.vertex(300, 200);
  g.vertex(140, 200);
  g.vertex(160, 160);
  g.vertex(240, 160);
  g.fill(x,y,z);
  g.endShape(CLOSE);
  
  b = createShape();
  b.beginShape();
  b.vertex(140, 80);
  b.vertex(60, 240);
  b.vertex(280, 240);
  b.vertex(300, 200);
  b.vertex(140, 200);
  b.vertex(160, 160);
  b.vertex(180, 120);
  b.fill(z,x,y);
  b.endShape(CLOSE);
  
  r = createShape();
  r.beginShape();
  r.vertex(140, 20);
  r.vertex(240, 160);
  r.vertex(200, 160);
  r.vertex(140, 80);
  r.vertex(60, 240);
  r.vertex(50, 215);
  r.fill(y,z,x);
  r.endShape(CLOSE);
  
shape(g, 0, 0);
shape(b, 0, 0);
shape(r, 0, 0);
}
void mouseClicked() {
  if(x == 255){
     x = 0;
     y = 255;
     z = 0;
     
  }else{
  if(y == 255){
     x = 0;
     y = 0;
     z = 255;
     
  }else{
  if(z == 255){
     x = 255;
     y = 0;
     z = 0;
     
  }
  }
  }
}
