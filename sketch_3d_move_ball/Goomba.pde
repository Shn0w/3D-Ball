class Goomba extends GameObject{
  PVector dir;
  
  Goomba(){
    super(random(0, map.width*gridSize)-2000, height-gridSize-20, random(0, map.height*gridSize)-2000, 50);
  }
  
  void show(){
    texturedCube(loc.x, loc.y, loc.z, goomba, size);
  }
  
  void act(){
    dir = new PVector(eyex - loc.x, 0, eyez-loc.z);
    dir.setMag(7);
    loc.add(dir);
  }
}

void spawnGoomba(){
  if(goombaRate<=0){
    objects.add(new Goomba());
    goombaRate = 300;
  } else{
    goombaRate--;
  }
    
}
