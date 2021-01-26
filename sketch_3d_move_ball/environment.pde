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

void drawFloor(int start, int end, int h, int gap) {
  world.stroke(255);
  world.strokeWeight(1);
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
