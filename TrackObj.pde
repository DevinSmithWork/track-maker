//=====================================
// TRACK
//=====================================

class track {

  ArrayList<section> secList = new ArrayList<section>();
  PShape trackShape;
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

    // Convert to array for visualizer
    // add the control point to the beginning
    // Add the control points to the end.
    nodeList.add(0, nodeList.get(nodeList.size()-1));
    nodeList.add(nodeList.get(1));
    nodeList.add(nodeList.get(2));

    // Convert arrayList to Array
    vizNodeArray = new node[nodeList.size()];
    vizNodeArray = nodeList.toArray(vizNodeArray);

    // TK!
    // Calculate Node Distances
    float runningTotal = 0;
    for (int i=1; i<vizNodeArray.length-2; i++) {

      float nodeDistance = 0;
      vizNodeArray[i].startPosition = runningTotal;
      float px, py, pz;
      px = py = pz = 0;

      for (float t=0.00; t<1.00; t+=0.01) {
        // Points
        float x = curvePoint(vizNodeArray[i-1].v.x, 
          vizNodeArray[i].v.x, 
          vizNodeArray[i+1].v.x, 
          vizNodeArray[i+2].v.x, 
          t);

        float y = curvePoint(vizNodeArray[i-1].v.y, 
          vizNodeArray[i].v.y, 
          vizNodeArray[i+1].v.y, 
          vizNodeArray[i+2].v.y, 
          t);

        float z = curvePoint(vizNodeArray[i-1].v.z, 
          vizNodeArray[i].v.z, 
          vizNodeArray[i+1].v.z, 
          vizNodeArray[i+2].v.z, 
          t);

        // first node
        if (t == 0.00) {
          px = x;
          py = y; 
          pz = z;
        } else {
          // add the distance
          nodeDistance += dist(px, py, pz, x, y, z);

          // swap out previous point
          px = x; 
          py = y; 
          pz = z;
        }
      }

      vizNodeArray[i].nodeLength = nodeDistance;
      runningTotal += nodeDistance;

      println("Node: " + i + ", rT: " + nodeDistance + ", rT: " + runningTotal);
    }












    // Create track shape
    // TK doesn't work

    trackShape = createShape();
    trackShape.beginShape();
    trackShape.noFill();
    trackShape.stroke(255);
    trackShape.strokeWeight(3);
    for (node n : vizNodeArray)
      trackShape.curveVertex(n.v.x, n.v.y, n.v.z);
    trackShape.endShape();
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
}


//==============================
class node {
  int nodeSize;
  PVector v;
  float startPosition, nodeLength;

  node(PVector nV) {
    v = nV;
    nodeSize = int(random(10, 20));
  }
}


//==============================
class segment {
}
