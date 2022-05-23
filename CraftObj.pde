//==============================
// Craft object
//==============================
class craft {
  byte totalSteps;
  int currentCurvePoint;
  color c;

  float baseSpeed;
  float totalPosition;

  int bobFrames, bobLimit;
  float bobHeight;

  //TK pick up here. Figure out how to influence the speed of the craft using this tan adjustment value.
  float speedAdjustment = 0.0;

  craft() {
    c = rCol();
    totalSteps = 20;

    baseSpeed = (appxFrameRate / totalSteps);
    println(baseSpeed);

    bobFrames = int(random(1, 10));
    bobLimit = int(random(20));
    bobHeight = 5;
  }

  void vizCraft() {
    //calcBob();

    if (frameCount % totalSteps == 0) currentCurvePoint++;
    drawCurvePoint(currentCurvePoint % (cTrack.vizNodeArray.length-3));
  }


  void calcBob() {
    bobHeight = sin(frameCount / float(bobFrames)) * bobLimit;
  }


  //--------------------
  void drawCurvePoint(int num) {
    noStroke();
    fill(c);

    // current step
    float t = (frameCount % totalSteps) / float(totalSteps);

    // Points
    float x = curvePoint(
      cTrack.vizNodeArray[num].v.x, 
      cTrack.vizNodeArray[num+1].v.x, 
      cTrack.vizNodeArray[num+2].v.x, 
      cTrack.vizNodeArray[num+3].v.x, 
      t);

    float y = curvePoint(cTrack.vizNodeArray[num].v.y, 
      cTrack.vizNodeArray[num+1].v.y, 
      cTrack.vizNodeArray[num+2].v.y, 
      cTrack.vizNodeArray[num+3].v.y, 
      t);

    float z = curvePoint(cTrack.vizNodeArray[num].v.z, 
      cTrack.vizNodeArray[num+1].v.z, 
      cTrack.vizNodeArray[num+2].v.z, 
      cTrack.vizNodeArray[num+3].v.z, 
      t);

    // Tangents
    float tx = curveTangent(
      cTrack.vizNodeArray[num].v.x, 
      cTrack.vizNodeArray[num+1].v.x, 
      cTrack.vizNodeArray[num+2].v.x, 
      cTrack.vizNodeArray[num+3].v.x, 
      t);

    float ty = curveTangent(
      cTrack.vizNodeArray[num].v.y, 
      cTrack.vizNodeArray[num+1].v.y, 
      cTrack.vizNodeArray[num+2].v.y, 
      cTrack.vizNodeArray[num+3].v.y, 
      t);

    float tz = curveTangent(
      cTrack.vizNodeArray[num].v.z, 
      cTrack.vizNodeArray[num+1].v.z, 
      cTrack.vizNodeArray[num+2].v.z, 
      cTrack.vizNodeArray[num+3].v.z, 
      t);

    pushMatrix();
    translate(x, y - bobHeight, z);
    sphere(5);

    // NOTE: -ty could be used to adjust the speed of the object. 
    stroke(c);
    strokeWeight(1);
    line(0, 0, 0, tx, -ty, tz);

    speedAdjustment = ty;

    popMatrix();
  }
}
