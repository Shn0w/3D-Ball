class Goomba extends GameObject {
  PVector dir;

  Goomba() {
    size = 100;
    int tmp = Math.round(random(1, 4));
    loc = new PVector(0, height-gridSize, 0);
    if (tmp==1) {
      loc.x = -2000;
      loc.z = random(gridSize*-20, map.height*gridSize-gridSize*20);
    } else if (tmp == 2) {
      loc.x = map.width*gridSize-gridSize*20;
      loc.z = random(gridSize*-20, map.height*gridSize-gridSize*20);
    } else if (tmp == 3) {
      loc.x = random(gridSize*-20, map.height*gridSize-gridSize*20);
      loc.z = gridSize*-20;
    } else if ( tmp ==4 ) {
      loc.x = random(gridSize*-20, map.height*gridSize-gridSize*20);
      loc.z = map.height*gridSize-gridSize*20;
    }
    lives = 4-bulletDmg;
  }

  void show() {
    texturedCube(loc.x, loc.y, loc.z, goomba, size);
  }

  void act() {
    if (charIsJumping) {
      dir = new PVector(beforeJump.x - loc.x, 0, beforeJump.z-loc.z);
      dir.setMag(5);
      loc.add(dir);
    } else {
      dir = new PVector(eyex - loc.x, 0, eyez-loc.z);
      dir.setMag(5);
      loc.add(dir);
      PVector character = new PVector(eyex, eyey, eyez);
      if (loc.dist(character)<=size+30 && invincTime==0) {
        lives = 0;
        numGoombaDead++;
        invincTime = 300;
        charLives--;
      }
      if (invincTime>0) {
        invincTime--;
      }
    }
  }
}

void spawnGoomba() {
  if (goombaRate<=0) {
    if (numGoomba<goombaPerRound) {
      objects.add(new Goomba());
      goombaRate = 60;
      numGoomba++;
    }
  } else {
    goombaRate--;
  }
}
