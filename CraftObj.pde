//==============================
// Craft object
//==============================
class craft {
  byte totalSteps;
  int currentCurvePoint;
  color c;

  craft() {
    totalSteps = 20;
    c = rCol();
  }

  void vizCraft() {
    if (frameCount % totalSteps >= 0) currentCurvePoint++;
    drawCurvePoint(currentCurvePoint % (cTrack.vizNodeArray.length-3));
  }



  void drawCurvePoint(int num) {
    noStroke();
    fill(c);

    float t = (frameCount % totalSteps) / float(totalSteps);

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

    pushMatrix();
    translate(x, y - 5, z);
    sphere(5);
    popMatrix();
  }
}
