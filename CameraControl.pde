float cameraRotateX;
float cameraRotateY = -PI/6;
float cameraSpeed = TWO_PI / width;

void mouseMoved() {
  cameraRotateX += (mouseX - pmouseX) * cameraSpeed;
  cameraRotateY += (pmouseY - mouseY) * cameraSpeed;
  cameraRotateY = constrain(cameraRotateY, -HALF_PI, 0);
}
