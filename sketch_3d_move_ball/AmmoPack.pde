class AmmoPack extends GameObject {
  boolean goUp;
  float rotate;
  AmmoPack() {
    super(random(gridSize*-10, gridSize*10), height-gridSize-50, random(gridSize*-10, gridSize*10), 75);
    int mapx = int(loc.x+2000)/gridSize;
    int mapy = int(loc.z+2000)/gridSize;
    while (map.get(mapx, mapy)!=white) {
      loc.x = random(gridSize*-10, gridSize*10);
      loc.z = random(gridSize*-10, gridSize*10);
      mapx = int(loc.x+2000)/gridSize;
      mapy = int(loc.z+2000)/gridSize;
    }
  }

  void show() {
    texturedCube(loc.x, loc.y, loc.z, ammoPack, size, rotate);
  }

  void act() {
    if (goUp) {
      loc.y--;
      if (loc.y<height-gridSize-50) {
        goUp = false;
      }
    } else {
      loc.y++;
      if (loc.y>height-gridSize-10) {
        goUp = true;
      }
    }
    rotate+=radians(1);
    PVector character = new PVector(eyex, loc.y, eyez);
    if (loc.dist(character)<=size+30) {
      lives = 0;
      numPacks--;
      ammo = Math.min(ammo+(50+magSize*25), magSize*100 + 100);
    }
  }
}

void addAmmoPack() {
  if (ammoPackRate<=0 &&  ammo<magSize*100 + 100 + 150 && numPacks<3) {
    objects.add(new AmmoPack());
    numPacks++;
    ammoPackRate = 600;
  } else {
    ammoPackRate--;
  }
}
