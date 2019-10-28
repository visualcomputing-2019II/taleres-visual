// Step 1. Import the video library.
import processing.video.*;


float[][] edgeDetectionKernel = {{ -1,  -1,  -1}, 
                    { -1,  8, -1}, 
                    { -1, -1, -1}};
                    
float[][] sharpenKernel = {{0, -1, 0}, 
                    { -1,  5, -1}, 
                    { 0, -1, 0}};
                    
float[][] identityKernel = {{0, 0, 0},
                          {0, 1, 0}, 
                          {0, 0, 0}};

float[][] gaussianBlurKernel = {{1, 2, 1},
                        {2, 4, 2},
                        {1, 2, 1}};
                    
PImage img;

PGraphics pg;
PGraphics pg2;
PGraphics pg3;
PGraphics pg4;








//Step 2. Declare a capture object.
Capture video;

// Step 5. Read from the camera when a new image is available!
void captureEvent(Capture video) {
  video.read();
}

void setup() {
  frameRate(30);
  printArray(Capture.list());
  size(640, 480);
  
  // Step 3. Initialize Capture object.
  video = new Capture(this, Capture.list()[0]);
  video.start();
  pg = createGraphics(320, 240);
  pg2 = createGraphics(320, 240);
  pg3 = createGraphics(320, 240);
  pg4 = createGraphics(320, 240);
  
  img = video; 
  
  
  // Step 4. Start the capturing process.
  
  
  

  
}

// Step 6. Display the image.
void draw() {
  line(0, 0, width, height);
  println(frameRate);
  pg.beginDraw();
    pg.image(img,0, 0,320, 240);
  pg.endDraw();
  
  
  pg2.beginDraw();
    PImage convolutionedImage = convolution(img, 1,  edgeDetectionKernel);
    pg2.image(convolutionedImage, 0, 0,320, 240);
  pg2.endDraw();
  
  pg3.beginDraw();
    convolutionedImage = convolution(img, 1, sharpenKernel);
    pg3.image(convolutionedImage, 0, 0,320, 240);
  pg3.endDraw();
  
  pg4.beginDraw();
    convolutionedImage = convolution(img, 16, gaussianBlurKernel);
    pg4.image(convolutionedImage, 0, 0,320, 240);
  pg4.endDraw();
  

  
  image(pg, 0, 0);
  image(pg2, width / 2, 0);
  image(pg3, 0, height / 2);
  image(pg4, width / 2, height / 2);
  
  
  
//  image(video, 0, 0, 320, 240);
}

PImage convolution(PImage img, float kernel, float[][] convolutionMatrix){
  PImage convolutioned = createImage(img.width, img.height, RGB);
  for (int y = 1; y < img.height-1; y++) { 
    for (int x = 1; x < img.width-1; x++) {
      float rtotal = 0.0;
      float gtotal = 0.0;
      float btotal = 0.0;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          int pos = (y + ky)*img.width + (x + kx);
          rtotal += (red(img.pixels[pos]) / kernel *convolutionMatrix[ky + 1][kx +1]);
          gtotal += (green(img.pixels[pos]) / kernel *convolutionMatrix[ky + 1][kx +1]);
          btotal += (blue(img.pixels[pos]) / kernel *convolutionMatrix[ky + 1][kx +1]);
        }
      }
      convolutioned.pixels[y*img.width + x] = color(rtotal, gtotal, btotal);
    }
  }
  convolutioned.updatePixels();
  return convolutioned;
}
