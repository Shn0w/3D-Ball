import java.awt.Robot;

float eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz;
//cam pos, cam facing point, tilt
boolean w, a, s, d;
float leftRightAngle, upDownAngle;
Robot rbt;

void setup() {
  try {
    rbt = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
  size(displayWidth, displayHeight, P3D);
  eyex = width/2;
  eyey = height/2;
  eyez = height/2;
  focusx = width/2;
  focusy = height/2;
  focusz = height/2 - 100;
  upx = 0;
  upy = 1;
  upz = 0;
}

void draw() {
  background(0);
  camera(eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz);
  move();

  drawAxis();
  drawFloor(-2000, 2000, height, 100);
  drawFloor(-2000, 2000, 0, 100);
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
  if (w) {
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

void drawAxis() {
}

void drawFloor(int start, int end, int h, int gap) {
  stroke(255);
  strokeWeight(1);
  for (int i = start; i<=end; i+=gap) {
    line(i, h, start, i, h, end);
    line(start, h, i, end, h, i);
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
