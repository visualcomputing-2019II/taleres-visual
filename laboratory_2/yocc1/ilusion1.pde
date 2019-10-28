    

int x1 = 100;
int y1 = 300;
int x2 = 300;
int y2 = 100;

int w1 = 300;
int z1 = 100;
int w2 = 500;
int z2 = 300;
boolean direction=true;
boolean visible = true;
int value = 0;
void setup() {
  size(700,600);

}
void draw() {
  //fill(value);
  background(200);
  stroke(0,0,0);
  line(x1-50, y1-50, x2-50, y2-50);
  line(x1+250, y1+250, x2+250, y2+250);
  
  line(w1, z1, w2, z2);
  line(w1-200, z1+200, w2-200, z2+200);
  if(direction){
    x1=x1+1;
    x2=x2+1;
    y1=y1+1;
    y2=y2+1;
  
    w1=w1+1;
    z1=z1-1;
    w2=w2+1;
    z2=z2-1;
    value+=1;
  }else{
    x1=x1-1;
    x2=x2-1;
    y1=y1-1;
    y2=y2-1;
  
    w1=w1-1;
    z1=z1+1;
    w2=w2-1;
    z2=z2+1;
    value+=1;
  }
  
  if(value ==20){
     direction= !direction;
     value=0;
  }
  stroke(255,0,0);
  if(visible){
    
    rect(220, 40, 110, 110, 10);
    rect(300, 460, 120, 120, 10);
    rect(50, 210, 100, 100, 10);
    rect(500, 280, 110, 110, 10);
    //quad(280,10, 350, 100, 280, 190, 200, 100);
  }
  
  //strokeCap(ROUND);
  
  strokeWeight(10);
}

void mouseClicked() {
  visible= !visible;
}
