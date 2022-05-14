//=====================================
// TRACK
//=====================================

class track {

  ArrayList<section> secList = new ArrayList<section>();

  // Create track
  track() {
    // sector size calculations
    byte numSec = byte(random(3, 6));
    float secSize = TWO_PI/numSec;
    float secOffset = secSize/3;

    // sector position calculations
    for (byte i=0; i<numSec; i++) {
      float secCenter = secSize * i;

      PVector secVector = new PVector(
        sin(random(secCenter - secOffset, secCenter + secOffset)), 
        random(-PI/8, PI/8), 
        cos(random(secCenter - secOffset, secCenter + secOffset)));

      float magnitude = random(50, 200);
      secVector.mult(magnitude);

      // Create new sector object and add to list
      section s = new section(secVector);
      secList.add(s);
    }
  }


  // Draw the track
  void viz() {

    // Guides Boxes
    if (drawGuides) {
      for (byte i=0; i<secList.size(); i++) {
        section s = secList.get(i);

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
          popMatrix();
        }
      }
    }


    // Track Road
    node startNode = secList.get(0).nodeList.get(0);

    noFill();
    stroke(255);
    strokeWeight(3);

    beginShape();
    curveVertex(startNode.v.x, startNode.v.y, startNode.v.z);

    for (byte i=0; i<secList.size(); i++) {
      section s = secList.get(i);
      for (byte j=0; j<s.nodeList.size(); j++) {
        node n = s.nodeList.get(j);
        curveVertex(n.v.x, n.v.y, n.v.z);
      }
    }

    curveVertex(startNode.v.x, startNode.v.y, startNode.v.z);
    curveVertex(startNode.v.x, startNode.v.y, startNode.v.z);
    endShape();
  }
}







//=====================================
// SECTION
//=====================================
class section {

  color c = rCol();
  ArrayList<node> nodeList = new ArrayList<node>();
  PVector v;

  section(PVector secV) {
    v = secV;

    byte numNodes = byte(random(5, 10));
    for (int i=0; i<numNodes; i++) {

      PVector nodeVector = new PVector(
        sin(v.heading() + (PI/numNodes * i)), 
        random(-PI/8, PI/8), 
        cos(v.heading() + (PI/numNodes * i)));

      float magnitude = random(40, 120);
      nodeVector.mult(magnitude);

      nodeVector.add(v);
      node n = new node(nodeVector);
      nodeList.add(n);
    }
  }



  void viz(section nextSec) {
    stroke(c);

    pushMatrix();
    translate(v.x, v.y, v.z);
    sphere(5);


    for (byte i=0; i<nodeList.size(); i++) {
      node n = nodeList.get(i);

      stroke(c);
      line(0, 0, 0, n.v.x, n.v.y, n.v.z);

      pushMatrix();
      translate(n.v.x, n.v.y, n.v.z);
      //box(n.nodeSize);
      popMatrix();

      // lines btw nodes
      node nNext;
      stroke(255);

      if (i != nodeList.size()-1) {
        nNext = nodeList.get(i+1);
        line(n.v.x, n.v.y, n.v.z, nNext.v.x, nNext.v.y, nNext.v.z);
      } else {
        //nNext = nodeList.get(0);

        popMatrix();

        line(
          v.x + n.v.x, 
          v.y + n.v.y, 
          v.z + n.v.z, 
          nextSec.v.x + nextSec.nodeList.get(0).v.x, 
          nextSec.v.y + nextSec.nodeList.get(0).v.y, 
          nextSec.v.z + nextSec.nodeList.get(0).v.z);

        // dummy push to even the pops
        pushMatrix();
      }
    }


    popMatrix();
  }
}



//==============================
class node {
  int nodeSize;
  PVector v;

  node(PVector nV) {
    v = nV;
    nodeSize = int(random(10, 20));
  }
}



//==============================
class segment {
}
