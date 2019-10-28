PImage pg;
PGraphics original;
PGraphics gris;
PGraphics gris2;
PGraphics histogram;
int ancho = 0;
int alto = 0;
int der = 0;
int izq = 255;
boolean rangoValido = true;
int newizq = 0;
int newder = 255;
String pg1 = "puente.jpeg";
//String pg1 = "newton.jpg";
String currentImage = pg1;
void setup() {
  size(637,350);
  pg = loadImage(currentImage); 
  alto = pg.height;
  ancho = pg.width;
  original= createGraphics(ancho,alto);
  gris= createGraphics(ancho,alto);
  gris2= createGraphics(ancho,alto);
  histogram = createGraphics(512,alto);
}
void draw() {
  pg = loadImage(currentImage);
  image(original,0,0);
  image(histogram,65,alto+10);
  image(gris2,ancho,0);
  original.beginDraw();
  original.image(pg, 0, 0);
  original.endDraw(); 
  gris.beginDraw();
  gris.loadPixels();
  for (int x = 0; x < alto*ancho; x++ ) {
    float prom = (red(pg.pixels[x])+blue(pg.pixels[x])+green(pg.pixels[x]))/3;
    gris.pixels[x] = color(prom,prom,prom);
  }
  gris.updatePixels();
  gris.endDraw();
  histogram.beginDraw();
  int[] hist = new int[256];
  for (int i = 0; i < gris.width; i++) {
  for (int j = 0; j < gris.height; j++) {
    int bright = int(brightness(get(i, j)));
    hist[bright]++; 
  }
}
  int histMax = max(hist);
  if(!rangoValido){
    histogram.background(255);
    histogram.line(der*2, pg.height, der*2, 0);
  }else{
    histogram.background(255);
    histogram.line(der*2, pg.height, der*2, 0);
    histogram.line(izq*2, pg.height, izq*2, 0);
    recalcular();
  }
  for (int i = 0; i < 256; i++) {
    int y = int(map(hist[i], 0, histMax, pg.height, 0));
    histogram.line(i*2, pg.height, i*2, y);
  } 
  histogram.stroke(0,0,0);
  histogram.endDraw();
  gris2.beginDraw();
  gris2.background(255,255,255);
  gris2.loadPixels();
  for (int x = 0; x < alto*ancho; x++ ) {
    float promedio = (red(pg.pixels[x])+blue(pg.pixels[x])+green(pg.pixels[x]))/3;
    if(promedio>=newizq && promedio<=newder){
      gris2.pixels[x] = color(promedio,promedio,promedio);
    }
  }
  gris2.updatePixels();
  gris2.endDraw();
}
void recalcular(){
  if(der<izq){
    newizq = der;
    newder = izq;
  }else{
    newizq = izq;
    newder = der;
  }
}
void mouseClicked() {
  if(mouseX>64 && mouseX<578 && mouseY>alto+10 &&  mouseY<alto*2+10){
    int pixel = (mouseX-64)/2;
    if(rangoValido){
      der = pixel;
      rangoValido = false;
    }else{
      izq = pixel;
      rangoValido = true;
    }
  }
}
