// Draws the current track.
// s : section
// n : node
// v : vector

void vizTrack() {

  if (drawGuides) vizGuides();

  //------------------------
  // Draw Road
   shape(cTrack.trackShape, 0, 0);
  
  /*
  noFill();
  stroke(255);
  strokeWeight(3);
  beginShape();
  for (node n : cTrack.vizNodeArray)
    curveVertex(n.v.x, n.v.y, n.v.z);
  endShape();
  */
}


//--------------------------
// Draws the guide boxes
//--------------------------
void vizGuides() {
  for (byte i=0; i < cTrack.secList.size(); i++) {
    section s = cTrack.secList.get(i);

    noFill();
    strokeWeight(1);
    stroke(s.c);
    line(0, 0, 0, s.v.x, s.v.y, s.v.z);

    pushMatrix();
    translate(s.v.x, s.v.y, s.v.z);
    sphere(10);
    popMatrix();

    for (byte j=0; j<s.nodeList.size(); j++) {
      node n = s.nodeList.get(j);
      line(s.v.x, s.v.y, s.v.z, 
        n.v.x, n.v.y, n.v.z);

      // node
      pushMatrix();
      translate(n.v.x, n.v.y, n.v.z);
      box(n.nodeSize);

      // Starting flag
      if (i==0 && j==0) {
        drawMarker();
      }
      popMatrix();
    }
  }
}
