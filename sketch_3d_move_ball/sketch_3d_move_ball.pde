import java.awt.Robot;

color black = #000000;
color white = #FFFFFF;
color dullBlue = #7092BE;

PImage mossyStone;
PImage oakPlanks;
PImage goomba;
PImage ammoPack;
PImage dirt;

int gridSize;
PImage map;

int mode;
final int START = 1;
final int GAME = 2;
final int BREAK = 3;
final int END = 4;

float eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz;
//cam pos, cam facing point, tilt
boolean w, a, s, d, space, mouse, b, f, m, j;
int fireRateTimer, cloudRate, goombaRate, ammoPackRate;
int timeInAir;
int ammo, numPacks;
int charLives;
float leftRightAngle, upDownAngle;
int invincTime;
int round;
int numGoomba;
int numGoombaDead;
int ms, jumpHeight, magSize, bulletDmg, fireRate;
int goombaPerRound;
int breakTime;
boolean charIsJumping;
PVector beforeJump;

Robot rbt;

ArrayList<GameObject> objects;

PGraphics world;
PGraphics HUD;

void setup() {
  mode = START;
  world = createGraphics(width, height, P3D);
  HUD = createGraphics(width, height, P2D);


  mossyStone = loadImage("Mossy_Stone_Bricks.png");
  oakPlanks = loadImage("Oak_Planks.png");
  goomba = loadImage("goombaface.jpg");
  ammoPack = loadImage("ammo pack.png");
  dirt = loadImage("dirt texture.png");

  try {
    rbt = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
  objects = new ArrayList<GameObject>();

  //noCursor();
  size(displayWidth, displayHeight, P2D);
  gridSize = 100;
  map = loadImage("map (2).png");

  bulletDmg = 3;
  fireRate = 3;
  magSize = 3;
  ms = 3;
  jumpHeight = 3;
}

void draw() {
  if (mode == START) {
    HUD.beginDraw();
    HUD.clear();
    drawStartMenu();
    HUD.endDraw();
    image(HUD, 0, 0);
  } else if (mode == GAME) {
    world.beginDraw();
    world.textureMode(NORMAL);
    world.background(255, 0, 0);
    world.lightFalloff(1.5, 0, 0);

    //world.ambientLight(255,255,255);
    world.pointLight(255, 255, 255, eyex, eyey, eyez);
    world.camera(eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz);
    moveChar();
    drawFloor(-2000, 2000, height, gridSize);
    drawMap();

    goombaPerRound = 5*round + 4;
    moveObjects();
    spawnGoomba();
    fire();
    addFlames();
    addClouds();
    addAmmoPack();
    world.endDraw();
    image(world, 0, 0);

    HUD.beginDraw();
    HUD.clear();
    if (invincTime>0) {
      showHit();
    }
    drawCrosshair();
    drawMinimap();
    drawAmmo();
    drawLives();
    drawNumGoomba();
    HUD.endDraw();
    image(HUD, 0, 0);

    if (numGoombaDead == goombaPerRound) {
      mode = BREAK;
      s = false;
      mouse = false;
      breakTime = 90;
    }
  } else if (mode == BREAK) {
    world.beginDraw();
    world.textureMode(NORMAL);
    world.background(255, 0, 0);
    world.lightFalloff(1.5, 0, 0);

    //world.ambientLight(255,255,255);
    world.pointLight(255, 255, 255, eyex, eyey, eyez);
    world.camera(eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz);
    drawFloor(-2000, 2000, height, gridSize);
    drawMap();
    moveObjects();
    addFlames();
    addClouds();
    world.endDraw();
    image(world, 0, 0);

    HUD.beginDraw();
    HUD.clear();
    drawBreak();
    HUD.endDraw();
    image(HUD, 0, 0);

    if (breakTime == 0) {
      if (b && bulletDmg<3) {
        bulletDmg++;
        newRound();
      } else if (f && fireRate<3) {
        fireRate++;
        newRound();
      } else if (s && magSize<3) {
        magSize++;
        newRound();
      } else if (j && jumpHeight<3) {
        jumpHeight++;
        newRound();
      } else if (m && ms<3) {
        ms++;
        newRound();
      } else if (bulletDmg==3 && fireRate == 3 && magSize==3 && ms == 3 && jumpHeight ==3 && mouse) {
        mouse = false;
        newRound();
      }
    } else{
      breakTime--;
    }
  } else if (mode == END) {
    world.beginDraw();
    world.textureMode(NORMAL);
    world.background(255, 0, 0);
    world.lightFalloff(1.5, 0, 0);

    //world.ambientLight(255,255,255);
    world.pointLight(255, 255, 255, eyex, eyey, eyez);
    world.camera(eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz);
    drawFloor(-2000, 2000, height, gridSize);
    drawMap();
    moveObjects();
    addFlames();
    addClouds();
    world.endDraw();
    image(world, 0, 0);

    HUD.beginDraw();
    HUD.clear();
    drawEndMenu();
    HUD.endDraw();
    image(HUD, 0, 0);
  }
}

void newRound() {
  mode = GAME;
  round++;
  numGoomba = 0;
  numGoombaDead = 0;
  charLives = 3;
}
