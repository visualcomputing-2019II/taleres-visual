PGraphics pg;
PGraphics pg2;
PGraphics pg3;

PImage img;
void setup() {
  size(610, 420);
  pg = createGraphics(300, 200);
  pg2 = createGraphics(300, 200);
  pg3 = createGraphics(300, 200);
  img = loadImage("laDefense.jpg"); 
}

void draw() {
  pg.beginDraw();
    pg.image(img,0, 0);
  pg.endDraw();
  
  
  pg2.beginDraw();    
    pg2.loadPixels();
    for(int i = 0; i < pg.pixels.length; i++){
      float r = red(pg.pixels[i]);
      float g = green(pg.pixels[i]);
      float b = blue(pg.pixels[i]);
      pg2.pixels[i] =  color((r+g+b)/3) ;
    }
    pg2.updatePixels();
  pg2.endDraw();
  
  pg3.beginDraw();    
    pg3.loadPixels();
    for(int i = 0; i < pg.pixels.length; i++){
      float r = red(pg.pixels[i]);
      float g = green(pg.pixels[i]);
      float b = blue(pg.pixels[i]);
      pg3.pixels[i] =  color( 0.2126* r + 0.7152*g + 0.0722*b) ;
    }
    pg3.updatePixels();
  pg3.endDraw();
  
  
  
  image(pg, 0, 0);
  image(pg2, width / 2, 0);
  image(pg3, 0, height / 2);
}
