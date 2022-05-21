//=====================================
// TRACK
//=====================================

class track {

  ArrayList<section> secList = new ArrayList<section>();
  node[] vizNodeArray;

  // Create track
  track() {
    // Temp AL for nodes. Converted to array later.
    ArrayList<node> nodeList = new ArrayList<node>();

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

      // Adds the nodes to the node list
      nodeList.addAll(s.nodeList);
    }

    // array for node vizualizer
    // add the control point to the beginning
    // Add the control points to the end.
    nodeList.add(0, nodeList.get(nodeList.size()-1));
    nodeList.add(nodeList.get(1));
    nodeList.add(nodeList.get(2));

    // Convert arrayList to Array
    vizNodeArray = new node[nodeList.size()];
    vizNodeArray = nodeList.toArray(vizNodeArray);
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


  // TK delete viz?
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
// Craft object
//==============================
class craft {
  node cNode, nextNode;
  byte cStep, totalSteps;

  craft() {
    cStep = 0;
    totalSteps = 10;

    cNode = cTrack.secList.get(0).nodeList.get(0);
    nextNode = cTrack.secList.get(0).nodeList.get(1);
  }

  void vizCraft() {
    // t = Float value btw 0 and 1.
    float t = cStep / float(totalSteps);

    // Move to next node if total steps
    if (cStep == totalSteps) {
    }
  }
}



//==============================
class segment {
}
