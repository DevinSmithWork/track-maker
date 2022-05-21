// UI vars
boolean drawGuides = true;
boolean rotateView = true;
boolean topView = false;
boolean drawCraft = true;

// Keyboard US
void keyPressed() {
  key = Character.toUpperCase(key);

  switch(key) {
    case('G'):
    drawGuides = !drawGuides;
    break;

    case('T'):
    topView = !topView;
    break;

    case('R'):
    rotateView = !rotateView;
    break;

    case('C'):
    rotateView = !rotateView;
    break;
  }
}


// Mouse click
void mouseClicked() {
  cTrack = new track();
  cCraft = new craft();
}
