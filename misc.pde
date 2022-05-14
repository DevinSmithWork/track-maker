// returns a random color
color rCol() {
  return(color(random(255), random(255), random(255)));
}

// Draws a marker
void drawMarker() {
  byte s = 20;
  line(-s, 0, 0, s, 0, 0);
  line(0, -s, 0, 0, s, 0);
  line(0, 0, -s, 0, 0, s);
}

// Suits
public enum Suit {
  CUPS, SWORDS, COINS, WANDS
}


// draws a dimaond
void diamond() {
  beginShape();

  endShape();
}
