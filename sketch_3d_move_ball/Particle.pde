class Particle extends GameObject {
  PVector dir;
  int fill;

  Particle(PVector loc) {
    super(loc.x, loc.y, loc.z, 5);
    dir = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    dir.setMag(20);
    loc.add(dir);
    fill = 255;
    world.fill(fill);
  }

  void show() {
    world.pushMatrix();
    world.translate(loc.x, loc.y, loc.z);
    world.fill(fill);
    world.stroke(fill);
    world.box(size);
    world.popMatrix();
  }

  void act() {
    loc.add(dir);
    if (fill<=100) {
      lives = 0;
    } else {
      fill-=5;
    }
  }
}
