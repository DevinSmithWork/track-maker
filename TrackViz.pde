// Draws the current track.
// t : track
// s : section
// n : node
// v : vector

void vizTrack(track pTrack) {
  track t = pTrack;

  // Guides Boxes
  if (drawGuides) {
    for (byte i=0; i<t.secList.size(); i++) {
      section s = t.secList.get(i);

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

  //------------------------
  // Track Road
  section preStartSec = t.secList.get(t.secList.size()-1);
  node preStartNode = preStartSec.nodeList.get(preStartSec.nodeList.size()-1);

  node startNode = t.secList.get(0).nodeList.get(0);
  node endNode = t.secList.get(0).nodeList.get(1);

  noFill();
  stroke(255);
  strokeWeight(3);

  beginShape();
  curveVertex(preStartNode.v.x, preStartNode.v.y, preStartNode.v.z);

  for (byte i=0; i<t.secList.size(); i++) {
    section s = t.secList.get(i);
    for (byte j=0; j<s.nodeList.size(); j++) {
      node n = s.nodeList.get(j);
      curveVertex(n.v.x, n.v.y, n.v.z);
    }
  }

  curveVertex(startNode.v.x, startNode.v.y, startNode.v.z);
  curveVertex(endNode.v.x, endNode.v.y, endNode.v.z);
  endShape();
}
