void drawStartMenu() {
  HUD.background(0);
  HUD.fill(white);
  HUD.textAlign(CENTER, CENTER);
  HUD.textSize(80);
  HUD.strokeWeight(0);
  HUD.text("OVERPOPULATED GOOMBAS", width/2, height/2-100);
  HUD.rectMode(CENTER);

  HUD.fill(white);
  HUD.rect(width/2, height/2+110, 350, 100);
  HUD.fill(black);
  HUD.text("START", width/2, height/2+100);

  if (mouse && mouseX>=width/2-350/2 && mouseX<=width/2+350/2 && mouseY>=height/2+110-100/2 && mouseY<=height/2+110+100/2) {
    if (frameCount < 2) {
      rbt.mouseMove(width/2, height/2);
      mouseX = width/2;
      mouseY = height/2;
    }
    objects.clear();
    mode = GAME;
    eyex = width/2;
    eyey = height-2*gridSize;
    eyez = height/2;
    focusx = width/2;
    focusy = height/2;
    focusz = height/2 - 100;
    upx = 0;
    upy = 1;
    upz = 0;
    ammo = 100;
    round = 1;
    numGoomba = 0;
    numGoombaDead = 0;
    charLives = 3;
    fireRateTimer = 0;
    cloudRate = 0; 
    goombaRate = 0;
    ammoPackRate = 0;
    timeInAir = 0;
    numPacks = 0;
    invincTime = 0;

    bulletDmg = 0;
    fireRate = 0;
    magSize = 0;
    ms = 0;
    jumpHeight = 0;

    for (int i = 0; i<10; i++) {
      objects.add(new Cloud());
    }
    mouse = false;
  }
}

void drawBreak() {
  if (bulletDmg==3 && fireRate == 3 && magSize==3 && ms == 3 && jumpHeight ==3) {
    HUD.textAlign(CENTER, CENTER);
    HUD.textSize(60);
    HUD.rectMode(CENTER);
    HUD.fill(black, 200);
    HUD.rect(width/2, height/2, 900, 800);
    HUD.fill(white);
    HUD.text("ROUND " + round + " COMPLETE", width/2, height/2-300);
    HUD.textSize(40);
    HUD.text("MAX UPGRADE - CLICK TO CONTINUE", width/2, height/2-200);
    HUD.text("BULLET DAMAGE (B) - " + bulletDmg + "/3", width/2, height/2 - 100);
    HUD.text("FIRE RATE (F) - " + fireRate + "/3", width/2, height/2);
    HUD.text("MAGAZINE SIZE (S) - " + magSize + "/3", width/2, height/2 + 100);
    HUD.text("MOVEMENT SPEED (M) - " + ms + "/3", width/2, height/2 +200);
    HUD.text("JUMP HEIGHT (J) - " + jumpHeight + "/3", width/2, height/2 + 300);
  } else {
    HUD.textAlign(CENTER, CENTER);
    HUD.textSize(60);
    HUD.rectMode(CENTER);
    HUD.fill(black, 200);
    HUD.rect(width/2, height/2, 900, 800);
    HUD.fill(white);
    HUD.text("ROUND " + round + " COMPLETE", width/2, height/2-300);
    HUD.textSize(40);
    HUD.text("CHOOSE AN UPGRADE", width/2, height/2-200);
    HUD.text("BULLET DAMAGE (B) - " + bulletDmg + "/3", width/2, height/2 - 100);
    HUD.text("FIRE RATE (F) - " + fireRate + "/3", width/2, height/2);
    HUD.text("MAGAZINE SIZE (S) - " + magSize + "/3", width/2, height/2 + 100);
    HUD.text("MOVEMENT SPEED (M) - " + ms + "/3", width/2, height/2 +200);
    HUD.text("JUMP HEIGHT (J) - " + jumpHeight + "/3", width/2, height/2 + 300);
  }
}

void drawEndMenu() {
  HUD.background(80, 0, 0, 180);
  HUD.fill(white);
  HUD.textAlign(CENTER, CENTER);
  HUD.textSize(80);
  HUD.strokeWeight(0);
  HUD.text("YOU DIED ON ROUND " + round, width/2, height/2-100);
  HUD.rectMode(CENTER);

  HUD.fill(white);
  HUD.rect(width/2, height/2+110, 450, 100);
  HUD.fill(black);
  HUD.text("RESTART", width/2, height/2+100);
  if (mouse && mouseX>=width/2-450/2 && mouseX<=width/2+450/2 && mouseY>=height/2+110-100/2 && mouseY<=height/2+110+100/2) {
    mouse = false;
    mode = START;
  }
}

void drawCrosshair() {
  HUD.stroke(white);
  HUD.strokeWeight(3);
  HUD.line(width/2-10, height/2, width/2+10, height/2);
  HUD.line(width/2, height/2-10, width/2, height/2+10);
}

void drawMinimap() {
  HUD.image(map, 50, 50, 160, 160);
  int miniX = int(eyex+2000)/gridSize;
  int miniY = int(eyez+2000)/gridSize;
  HUD.textSize(20);
  HUD.fill(white);

  HUD.strokeWeight(0);
  HUD.stroke(255, 0, 0);
  HUD.fill(0, 0, 255);
  HUD.rect(miniX*4+50, miniY*4+50, 4, 4);

  HUD.fill(255, 0, 0);
  for (int i =0; i<objects.size(); i++) {
    GameObject tmp = objects.get(i);
    if (tmp instanceof Goomba) {
      int x = int(tmp.loc.x+2000)/gridSize;
      int y = int(tmp.loc.z+2000)/gridSize;
      HUD.rect(x*4+50, y*4+50, 4, 4);
    }
  }
}

void drawAmmo() {
  HUD.textAlign(RIGHT);

  HUD.textSize(30);
  HUD.fill(white);
  HUD.text("Bullets: " + ammo + "/" + (magSize*100 + 100), width-20, 100);
}

void drawLives() {
  HUD.textAlign(RIGHT);
  HUD.textSize(30);
  HUD.fill(white);
  HUD.text("Lives: " + charLives, width-20, 50);
}

void drawNumGoomba() {
  HUD.textAlign(RIGHT);

  HUD.textSize(30);
  HUD.fill(white);
  HUD.text("Goombas Left: " + (goombaPerRound - numGoombaDead), width-20, 150);
}

void showHit() {
  HUD.fill(180, 0, 0);
  HUD.strokeWeight(2);
  HUD.stroke(0);
  int w = 100;
  int h = 60;
  for (int x = 0; x<=width; x+=w) {
    HUD.triangle(x, 0, x+w/2, h, x+w, 0);
  }
  for (int x = 0; x<=width; x+=w) {
    HUD.triangle(x, height, x+w/2, height-h, x+w, height);
  }
  for (int y = 0; y<=height; y+=w) {
    HUD.triangle(0, y, h, y+w/2, 0, y+w);
  }
  for (int y = 0; y<=height; y+=w) {
    HUD.triangle(width, y, width-h, y+w/2, width, y+w);
  }
}
