void keyPressed() {
  if (key=='w' || key== 'W') w = true;
  if (key=='s' || key=='S') s = true;
  if (key =='a' || key=='A') a = true;
  if (key=='d' || key =='D') d = true;
  if (key==' ') space = true;
  if (Character.toLowerCase(key) == 'b') b = true;
  if (Character.toLowerCase(key) == 'f') f = true;
  if (Character.toLowerCase(key) == 'm') m = true;
  if (Character.toLowerCase(key) == 'j') j = true;
}

void keyReleased() {
  if (key=='w' || key== 'W') w = false;
  if (key=='s' || key=='S') s = false;
  if (key =='a' || key=='A') a = false;
  if (key=='d' || key =='D') d = false;
  if (key==' ') space = false;
  if (Character.toLowerCase(key) == 'b') b = false;
  if (Character.toLowerCase(key) == 'f') f = false;
  if (Character.toLowerCase(key) == 'm') m = false;
  if (Character.toLowerCase(key) == 'j') j = false;
}

void mousePressed() {
  mouse = true;
}

void mouseReleased() {
  mouse = false;
}
