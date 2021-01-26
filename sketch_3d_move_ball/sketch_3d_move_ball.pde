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
boolean w, a, s, d, space;
int fireRate;
float leftRightAngle, upDownAngle;
Robot rbt;

ArrayList<GameObject> objects;

PGraphics world;
PGraphics HUD;

void setup() {
  world = createGraphics(width, height, P3D);
  HUD = createGraphics(width, height, P2D);

  objects = new ArrayList<GameObject>();

  mossyStone = loadImage("Mossy_Stone_Bricks.png");
  oakPlanks = loadImage("Oak_Planks.png");

  try {
    rbt = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
  noCursor();
  size(displayWidth, displayHeight, P2D);
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
  world.beginDraw();
  world.textureMode(NORMAL);
  world.background(0);
  world.pointLight(255, 255, 255, eyex, eyey, eyez);
  world.camera(eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz);
  move();

  drawAxis();
  drawFloor(-2000, 2000, height, gridSize);
  drawFloor(-2000, 2000, height-gridSize*4, gridSize);
  drawMap();

  if (space && fireRate<=0) {
    objects.add(new Bullet());
    fireRate = 5;
  }
  if (fireRate>0) {
    fireRate--;
  }
  for (int i =0; i<objects.size(); i++) {
    GameObject obj = objects.get(i);
    obj.act();
    obj.show();
    if (obj.lives==0) {
      objects.remove(i);
      i--;
    }
  }
  world.endDraw();
  image(world, 0, 0);
  
  HUD.beginDraw();
  drawCrosshair();
  drawMinimap();
  
  HUD.endDraw();
  image(HUD,0,0);
}


void drawAxis() {
}
