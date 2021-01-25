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

ArrayList<GameObject> objects;

void setup() {
  objects = new ArrayList<GameObject>();
  
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
  
  for(int i =0; i<objects.size(); i++){
    GameObject obj = objects.get(i);
    obj.act();
    obj.show();
    if(obj.lives==0){
      objects.remove(i);
      i--;
    }
  }
}


void drawAxis() {
}
