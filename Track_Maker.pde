track cTrack = new track();

void setup() {
  size(620,480, P3D);
  
  rectMode(CENTER);
  sphereDetail(6);
}

void draw() {
  background(153);
  
//beginCamera();
//camera();
//rotateX(-PI/6);
//endCamera();
  
  translate(width/2,height/2,0);
  rotateY(radians(frameCount/3.4));
  
  noFill();
  cTrack.viz();
}
