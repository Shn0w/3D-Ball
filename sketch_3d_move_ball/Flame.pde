class Flame extends GameObject {

  Flame() {
    super(random(-4000, map.width*gridSize), -10000, random(-4000, map.height*gridSize), 3);
  }

  void show() {
    world.pushMatrix();
    world.translate(loc.x, loc.y, loc.z);
    world.fill(95, 0, 0);
    world.stroke(0);
    world.strokeWeight(1);
    world.box(size, 8, size);
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
  for (int i = 0; i<7; i++) {
    objects.add(new Flame());
  }
}
