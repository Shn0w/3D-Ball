void move() {
  if (a && canMoveLeft()) { 
    eyex -= cos(leftRightAngle+PI/2)*10;
    eyez -= sin(leftRightAngle+PI/2)*10;
  }
  if (d && canMoveRight()) {
    eyex += cos(leftRightAngle+PI/2)*10;
    eyez += sin(leftRightAngle+PI/2)*10;
  }
  if (w && canMoveForward()) {
    eyex += cos(leftRightAngle)*10;
    eyez += sin(leftRightAngle)*10;
  }
  if (s && canMoveBackward()) { 
    eyex -= cos(leftRightAngle)*10;
    eyez -= sin(leftRightAngle)*10;
  }
  if (space && eyey>=height-gridSize-100) {
    eyey -= 17 + (-1*timeInAir);
  }
  if (eyey>=height-gridSize-100) {
    timeInAir=0;
  } else {
    timeInAir++;
    eyey -= 17 + (-1*timeInAir);
  }

  focusx = eyex + cos(leftRightAngle)*100;
  focusy = eyey + tan(upDownAngle)*100;
  focusz = eyez + sin(leftRightAngle)*100;
  if (mouseX>width-2) { 
    rbt.mouseMove(3, mouseY);
  }  
  if (mouseX<2) {
    rbt.mouseMove(width-3, mouseY);
  }  
  if (mouseY>height-2) { 
    rbt.mouseMove(mouseX, 3);
  } 
  if (mouseY<2) {
    rbt.mouseMove(mouseX, height-3);
  } 
  leftRightAngle += (mouseX - pmouseX)*0.004;
  upDownAngle += (mouseY-pmouseY)*0.004;

  if (upDownAngle > radians(89)) upDownAngle = radians(89);
  if (upDownAngle< -radians(89)) upDownAngle = -radians(89);
}

void fire() {
  if (mouse && fireRate<=0) {
    objects.add(new Bullet());
    fireRate = 6;
  }
  if (fireRate>0) {
    fireRate--;
  }
}

boolean canMoveForward() {
  float fwdx, fwdy, fwdz;
  int mapx, mapy;
  for (int i = -45; i<=45; i++) {
    fwdx = eyex + cos(leftRightAngle+radians(i))*80;
    fwdy = eyey;
    fwdz = eyez + sin(leftRightAngle+radians(i))*80;
    mapx = int(fwdx+2000)/gridSize;
    mapy = int(fwdz+2000)/gridSize;
    if (map.get(mapx, mapy)!=white) {
      return false;
    }
  }
  return true;
}

boolean canMoveLeft() {
  float fwdx, fwdy, fwdz;
  int mapx, mapy;
  for (int i = -45; i<=45; i++) {
    fwdx = eyex + cos(leftRightAngle+radians(i)-radians(90))*80;
    fwdy = eyey;
    fwdz = eyez + sin(leftRightAngle+radians(i)-radians(90))*80;
    mapx = int(fwdx+2000)/gridSize;
    mapy = int(fwdz+2000)/gridSize;
    if (map.get(mapx, mapy)!=white) {
      return false;
    }
  }
  return true;
}

boolean canMoveRight() {
  float fwdx, fwdy, fwdz;
  int mapx, mapy;
  for (int i =-45; i<=45; i++) {
    fwdx = eyex + cos(leftRightAngle+radians(i)+radians(90))*80;
    fwdy = eyey;
    fwdz = eyez + sin(leftRightAngle+radians(i)+radians(90))*80;
    mapx = int(fwdx+2000)/gridSize;
    mapy = int(fwdz+2000)/gridSize;
    if (map.get(mapx, mapy)!=white) {
      return false;
    }
  }
  return true;
}

boolean canMoveBackward() {
  float fwdx, fwdy, fwdz;
  int mapx, mapy;
  for (int i = -45; i<=45; i++) {
    fwdx = eyex + cos(leftRightAngle+radians(i)+radians(180))*80;
    fwdy = eyey;
    fwdz = eyez + sin(leftRightAngle+radians(i)+radians(180))*80;
    mapx = int(fwdx+2000)/gridSize;
    mapy = int(fwdz+2000)/gridSize;
    if (map.get(mapx, mapy)!=white) {
      return false;
    }
  }
  return true;
}
