class Flame extends GameObject {

  Flame() {
    super(random(0, map.width*gridSize)-2000, -10000, random(0, map.height*gridSize)-2000, 5);
  }

  void show() {
    world.pushMatrix();
    world.translate(loc.x, loc.y, loc.z);
    world.fill(255, 0, 0);
    world.stroke(0);
    world.box(size, 7, size);
    world.popMatrix();
  }

  void act() {
    if (loc.y>height-gridSize+20) {
      lives = 0;
    } else {
      loc.y+=50;
    }
  }
}

void addFlames() {
  for (int i = 0; i<5; i++) {
    objects.add(new Flame());
  }
}
