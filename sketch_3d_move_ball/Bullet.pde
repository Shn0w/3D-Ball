class Bullet extends GameObject {
  PVector dir;
  float speed;

  Bullet() {
    super(eyex, eyey, eyez, 8);
    speed = 80;
    float vx = cos(leftRightAngle);
    float vy = tan(upDownAngle);
    float vz = sin(leftRightAngle);
    dir = new PVector(vx, vy, vz);
    dir.setMag(speed);
  }

  void act() {
    int hitx = int(loc.x+2000)/gridSize;
    int hity = int(loc.z+2000)/gridSize;
    for (int i = 0; i<objects.size(); i++) {
      if (objects.get(i) instanceof Goomba) {
        if (loc.dist(objects.get(i).loc)<=objects.get(i).size + size) {
          lives = 0;
          objects.get(i).lives--;
          for (int j = 0; j<17; j++) {
            objects.add(new Particle(loc));
          }
        }
      }
    }
    if (map.get(hitx, hity) == white && loc.y < height && loc.y>-1000) {
      loc.add(dir);
    } else if (loc.y<=-1000) {
      lives = 0;
    } else {
      lives = 0;
      for (int i = 0; i<17; i++) {
        objects.add(new Particle(loc));
      }
    }
  }
}
