void setup () {
        size(600, 600);
    }

void draw (){
        background(0, 0, 0);
        // line(150, 25, mouseX, mouseY);
       
        for (int m = 0; m < 13; m = m + 2) {
            for (int i = -10; i < 10; i++) {
                rect(mouseX + (i * 120), m * 60, 60, 60);
            }
            for (int i = -10; i < 10; i++) {
                rect(600 - mouseX + (i * 120), (m + 1) * 60, 60, 60);
            }
        }
        for (int m = 1; m < 13; m++) {
            strokeWeight(2);
            stroke(126);
            line(0, m * 60, 600, m * 60);
            strokeWeight(1);
            stroke(0);
        }
    }
