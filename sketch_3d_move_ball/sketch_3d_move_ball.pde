import java.awt.Robot;

color black = #000000;
color white = #FFFFFF;
color dullBlue = #7092BE;


PImage mossyStone;
PImage oakPlanks;

int gridSize;
PImage map;

float eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz;
//cam pos, cam facing point, tilt
boolean w, a, s, d;
float leftRightAngle, upDownAngle;
Robot rbt;

void setup() {
  mossyStone = loadImage("Mossy_Stone_Bricks.png");
  oakPlanks = loadImage("Oak_Planks.png");
  textureMode(NORMAL);

  try {
    rbt = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
  size(displayWidth, displayHeight, P3D);
  gridSize = 100;

  eyex = width/2;
  eyey = height-2*gridSize;
  eyez = height/2;
  focusx = width/2;
  focusy = height/2;
  focusz = height/2 - 100;
  upx = 0;
  upy = 1;
  upz = 0;

  map = loadImage("map.png");
}

void draw() {
  background(0);
  pointLight(255, 255, 255, eyex, eyey, eyez);
  camera(eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz);
  move();

  drawAxis();
  drawFloor(-2000, 2000, height, gridSize);
  drawFloor(-2000, 2000, height-gridSize*4, gridSize);
  drawMap();
}

void drawMap() {
  for (int x = 0; x<map.width; x++) {
    for (int y = 0; y<map.height; y++) {
      color c = map.get(x, y);
      if (c==dullBlue) {
        texturedCube(x*gridSize-2000, height-gridSize, y*gridSize-2000, mossyStone, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*2, y*gridSize-2000, mossyStone, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*3, y*gridSize-2000, mossyStone, gridSize);
      } else if (c==black) {
        texturedCube(x*gridSize-2000, height-gridSize, y*gridSize-2000, oakPlanks, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*2, y*gridSize-2000, oakPlanks, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*3, y*gridSize-2000, oakPlanks, gridSize);
      }
    }
  }
}

void move() {
  pushMatrix();
  translate(focusx, focusy, focusz);
  sphere(4);
  popMatrix();
  if (a) { 
    eyex -= cos(leftRightAngle+PI/2)*10;
    eyez -= sin(leftRightAngle+PI/2)*10;
  }
  if (d) {
    eyex += cos(leftRightAngle+PI/2)*10;
    eyez += sin(leftRightAngle+PI/2)*10;
  }
  if (w && canMoveForward()) {
    eyex += cos(leftRightAngle)*10;
    eyez += sin(leftRightAngle)*10;
  }
  if (s) { 
    eyex -= cos(leftRightAngle)*10;
    eyez -= sin(leftRightAngle)*10;
  }
  focusx = eyex + cos(leftRightAngle)*100;
  focusy = eyey + tan(upDownAngle)*100;
  focusz = eyez + sin(leftRightAngle)*100;
  leftRightAngle += (mouseX - pmouseX)*0.004;
  upDownAngle+= (mouseY-pmouseY)*0.004;
  if (upDownAngle > radians(89)) upDownAngle = radians(89);
  if (upDownAngle< -radians(89)) upDownAngle = -radians(89);

  if (mouseX>width-2) rbt.mouseMove(3, mouseY);
  if (mouseX<2) rbt.mouseMove(width-3, mouseY);
  if (mouseY>height-2) rbt.mouseMove(mouseX, 3);
  if (mouseY<2) rbt.mouseMove(mouseX, height-3);
}

boolean canMoveForward() {
  float fwdx, fwdy, fwdz;
  float leftx, lefty, leftz;
  float rightx, righty, rightz;
  int mapx, mapy;
  fwdx = eyex + cos(leftRightAngle)*100;
  fwdy = eyey;
  fwdz = eyez + sin(leftRightAngle)*100;
  leftx = eyex + cos(leftRightAngle-radians(30))*100;
  lefty = eyey;
  leftz = eyez + sin(leftRightAngle-radians(30))*100;
  rightx = eyex + cos(leftRightAngle-radians(30))*100;
  righty = eyey;
  rightz = eyez + sin(leftRightAngle-radians(30))*100;
  mapx = int(fwdx+2000)/gridSize;
  mapy = int(fwdz+2000)/gridSize;
  if (map.get(mapx, mapy) == white) {
    return true;
  } else {
    return false;
  }
}

boolean canMoveLeft() {
  return false;
}

boolean canMoveRight() {
  return false;
}

boolean canMoveBackward() {
  return false;
}

void drawAxis() {
}

void drawFloor(int start, int end, int h, int gap) {
  stroke(255);
  strokeWeight(1);
  int x = start;
  int z = start;
  while (z<end) {
    texturedCube(x, h, z, oakPlanks, gap);
    x+=gap;
    if (x>=end) {
      x=start;
      z+=gap;
    }
  }
}


void keyPressed() {
  if (key=='w' || key== 'W') w = true;
  if (key=='s' || key=='S') s = true;
  if (key =='a' || key=='A') a = true;
  if (key=='d' || key =='D') d = true;
}

void keyReleased() {
  if (key=='w' || key== 'W') w = false;
  if (key=='s' || key=='S') s = false;
  if (key =='a' || key=='A') a = false;
  if (key=='d' || key =='D') d = false;
}
