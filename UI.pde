void mouseClicked() {
  cTrack = new track();
}

boolean drawGuides = true;

// Keyboard US
void keyPressed() {
  key = Character.toUpperCase(key);
  
  switch(key) {
    case('G'):
    drawGuides = !drawGuides;
    println("Guides ON/OFF");
    break;
  }
}
