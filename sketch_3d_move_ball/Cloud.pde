class Cloud extends GameObject {
  int xSize;
  int zSize;
  Cloud() {
    super(random(gridSize*-50, map.width*gridSize + gridSize*10), -2000, random(gridSize*-50, map.height*gridSize + gridSize*10), 0);
    xSize = (int)random(800, 2000);
    zSize = (int)random(800, 2000);
  }

  Cloud(int posX, int posZ) {
    super(posX, -2000, posZ, 0);
    xSize = (int)random(800, 2000);
    zSize = (int)random(800, 2000);
  }

  void show() {
    world.pushMatrix();
    world.translate(loc.x, loc.y, loc.z);
    strokeWeight(0);
    world.fill(100);
    world.box(xSize, 100, zSize);
    world.popMatrix();
  }

  void act() {
    loc.x+=3;
  }
}

void addClouds() {
  if (cloudRate<=0) {
    objects.add(new Cloud(gridSize*-50, (int)random(gridSize*-50, map.height*gridSize + gridSize*10 )));
    cloudRate = 150;
  } else {
    cloudRate--;
  }
}
