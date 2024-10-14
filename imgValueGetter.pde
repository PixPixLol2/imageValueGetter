final float WINDOW_WIDTH = 1280;
final float WINDOW_HEIGHT = 720;
final color BACKGROUND_COLOR = color(255, 255, 255);
final float FRAME_RATE = 60;

PImage[] images;
int imageCount = 0;
int selectedImageIndex = -1;
float[] imageX, imageY, imageW, imageH, aspectRatio;
boolean dragging = false;
float dragOffsetX, dragOffsetY;
boolean overButton = false;

void settings() {
  size((int)WINDOW_WIDTH, (int)WINDOW_HEIGHT);
}

void setup() {
  frameRate(FRAME_RATE);
  background(BACKGROUND_COLOR);
  
  images = new PImage[10];
  images[0] = loadImage("image1.png");
  //images[1] = loadImage("image2.png");
  imageCount = 1;
  
  imageX = new float[imageCount];
  imageY = new float[imageCount];
  imageW = new float[imageCount];
  imageH = new float[imageCount];
  aspectRatio = new float[imageCount];
  
  for (int i = 0; i < imageCount; i++) {
    imageX[i] = 50 + i * 150;
    imageY[i] = 50;
    imageW[i] = images[i].width / 2;
    imageH[i] = images[i].height / 2;
    aspectRatio[i] = images[i].width / (float)images[i].height;
  }
}

void draw() {
  background(BACKGROUND_COLOR);

  for (int i = 0; i < imageCount; i++) {
    image(images[i], imageX[i], imageY[i], imageW[i], imageH[i]);
  }

  if (mouseX > width - 100 && mouseY < 50) {
    overButton = true;
    fill(200, 100, 100);
  } else {
    overButton = false;
    fill(100, 100, 100);
  }

  rect(width - 100, 0, 100, 50);
  fill(255);
  text("Get Image Values", width - 90, 30);

  if (dragging && selectedImageIndex >= 0) {
    imageX[selectedImageIndex] = mouseX - dragOffsetX;
    imageY[selectedImageIndex] = mouseY - dragOffsetY;
  }
}

void mousePressed() {
  if (overButton && selectedImageIndex >= 0) {
    println("Selected Image Position: ", imageX[selectedImageIndex], imageY[selectedImageIndex]);
    println("Selected Image Size: ", imageW[selectedImageIndex], imageH[selectedImageIndex]);
  } else {
    for (int i = 0; i < imageCount; i++) {
      if (mouseX > imageX[i] && mouseX < imageX[i] + imageW[i] &&
          mouseY > imageY[i] && mouseY < imageY[i] + imageH[i]) {
        selectedImageIndex = i;
        dragging = true;
        dragOffsetX = mouseX - imageX[i];
        dragOffsetY = mouseY - imageY[i];
        break;
      }
    }
  }
}

void mouseReleased() {
  dragging = false;
}

void keyPressed() {
  if (selectedImageIndex >= 0) {
    if (keyCode == UP) {
      imageY[selectedImageIndex] -= 10;
    } else if (keyCode == DOWN) {
      imageY[selectedImageIndex] += 10;
    } else if (keyCode == LEFT) {
      imageX[selectedImageIndex] -= 10;
    } else if (keyCode == RIGHT) {
      imageX[selectedImageIndex] += 10;
    }

    if (key == '+') {
      imageW[selectedImageIndex] += 10;
      imageH[selectedImageIndex] = imageW[selectedImageIndex] / aspectRatio[selectedImageIndex];
    } else if (key == '-') {
      imageW[selectedImageIndex] -= 10;
      imageH[selectedImageIndex] = imageW[selectedImageIndex] / aspectRatio[selectedImageIndex];
    }
  }
}
