class Goomba extends GameObject {
  PVector dir;

  Goomba() {
    size =50;
    int tmp = Math.round(random(1, 4));
    loc = new PVector(0, height-gridSize-20, 0);
    if (tmp==1) {
      loc.x = -2000;
      loc.z =  random(0, map.height*gridSize)-2000;
    } else if (tmp == 2) {
      loc.x = map.width*gridSize-2000;
      loc.z = random(0, map.height*gridSize)-2000;
    } else if (tmp == 3) {
      loc.x = random(0, map.width*gridSize)-2000;
      loc.z = -2000;
    } else if ( tmp ==4 ) {
      loc.x = random(0, map.width*gridSize)-2000;
      loc.z = map.width*gridSize-2000;
    }
    lives = 2;
  }

  void show() {
    texturedCube(loc.x, loc.y, loc.z, goomba, size);
  }

  void act() {
    dir = new PVector(eyex - loc.x, 0, eyez-loc.z);
    dir.setMag(7);
    loc.add(dir);
  }
}

void spawnGoomba() {
  if (goombaRate<=0) {
    objects.add(new Goomba());
    goombaRate = 60;
  } else {
    goombaRate--;
  }
}
