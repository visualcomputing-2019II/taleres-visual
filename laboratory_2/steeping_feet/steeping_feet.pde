int squareSize = 80;
int position = 40;
int direction = 0;

void setup() {
  size(500, 500);
}

void draw() {
  background(124.75);
  
   if (position > width - squareSize) {
    direction = 1;
  }
  if (position == 0) {
    direction = 0;
  }
  if (direction == 0) {
    position++;
  }
  else {
    position--;
  }
 
  
  if(!mousePressed){
    background(255);
    rectMode(CORNER);
    noStroke();
    fill(0);
    for (int i = 0; i < width; i += 40) {
      rect(i, 0, 20, height);
    }
  }
  rectMode(CORNER);
  fill(0);
  rect(position, (height / 6), squareSize, squareSize - 5);
  rect(position, (3 * height / 6), squareSize, squareSize - 5);
  fill(255);
  rect(position, (2 * height / 6), squareSize, squareSize - 5);
  rect(position, (4 * height / 6), squareSize, squareSize - 5);

}
