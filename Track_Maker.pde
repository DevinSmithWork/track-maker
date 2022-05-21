track cTrack = new track();
craft cCraft = new craft();

//--------------------
// Setup
void setup() {
  size(620, 480, P3D);

  rectMode(CENTER);
  sphereDetail(6);
}

//--------------------
// Main
void draw() {
  background(153);

  //beginCamera();
  //camera();
  //rotateX(-PI/6);
  //endCamera();

  translate(width/2, height/2, 0);
  if (topView) rotateX(HALF_PI);
  if (rotateView) rotateY(radians(frameCount/3.4));

  noFill();
  vizTrack();
  if (drawCraft) cCraft.vizCraft();
}
