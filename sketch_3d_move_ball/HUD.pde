void drawCrosshair() {
  HUD.stroke(white);
  HUD.strokeWeight(5);
  HUD.line(width/2-10, height/2, width/2+10, height/2);
  HUD.line(width/2, height/2-10, width/2, height/2+10);
}

void drawMinimap(){
  image(map, 50, 50, 160, 160);
}
