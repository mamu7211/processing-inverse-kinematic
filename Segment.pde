static class StaticSegment {
  static boolean showLetters = true;
}

class Segment extends StaticSegment {

  PVector a;
  PVector b;
  float len;
  float angle;
  int col;
  int segmentNumber;
  float constraintStart = -PI/2.0;
  float constraintEnd = PI/2.0;
  float relativeAngle = 0.0;
  float baseAngle = 0.0;
  boolean hitConstraint = false;
  
  Segment(int segmentNumber, float x, float y, float angle, float len, int col) {
    this.b = new PVector(x, y);
    this.angle = angle;
    this.len = len;
    this.col = col;
    this.segmentNumber = segmentNumber;
    calculateA();
  }
  
  void setConstraint(float constraintStart, float constraintEnd) {
    this.constraintStart = constraintStart;
    this.constraintEnd = constraintEnd;
  }

  void follow(float targetX, float targetY) {
    PVector target = new PVector(targetX, targetY);
    PVector direction = PVector.sub(target, a);
    angle = direction.heading();
    b = new PVector(targetX, targetY);
    calculateA();
  }

  void calculateA() {
    PVector offset = PVector.fromAngle(angle);
    offset.mult(len);
    a = PVector.sub(b, offset);
  }
  
  void setBase(float baseX, float baseY, float priorAngle) {
    PVector direction = PVector.sub(b, a);
    a = new PVector(baseX, baseY);
    b = PVector.add(a, direction);
    //TODO - instead of setting base, do forward kinematic??
    float angleAToB = PVector.sub(b, a).heading() + priorAngle;
    baseAngle = angleAToB;
    if (angleAToB < constraintStart || angleAToB > constraintEnd) {
      //TODO
      hitConstraint = true;
    }else{
      hitConstraint = false;
    }
}

  void show(float parentAngle) {
    stroke(col,196);
    noFill();
    strokeWeight(4);
    line(a.x, a.y, b.x, b.y);
    circle(b.x, b.y, 16);
    circle(a.x, a.y, 8);
    noStroke();
    noFill();
    
    if (showLetters) {
      printLetter("A", a, -1.0, true);
      printLetter("B", b, 1.0, true);
      PVector t = new PVector(a.x + 32.0, a.y);
      printLetter(String.format("%d° [%d°...%d°] (base:%d°)",
          (int) degrees(relativeAngle), 
          (int) degrees(constraintStart),
          (int) degrees(constraintEnd),
          (int) degrees(baseAngle)
        ),        t, -1.0, false);
    }
    
    fill(col,128);
    arc(a.x, a.y, len/2.0, len/2.0, constraintStart + parentAngle, constraintEnd + parentAngle);
    if (hitConstraint){
      strokeWeight(15);
      noFill();
      stroke(col,128);
      arc(a.x, a.y, len/2.0, len/2.0, constraintStart + parentAngle, constraintEnd + parentAngle);
    }
    noStroke();
    noFill();
    strokeWeight(1);
  }

  void printLetter(String letter, PVector v, float dir, boolean addNumber) {
    float diameter = 32.0;
    textSize(diameter / 2.0);    
    PVector offs = new PVector(22,20).mult(dir);
    PVector pvText = new PVector(v.x - diameter / 2.0 + 8.0, v.y + 8.0).add(offs);
    fill(col);
    String indicator = String.format("%s", letter);
    if (addNumber){
      indicator = String.format("%s%d", letter, segmentNumber);
    }
    text(indicator, pvText.x, pvText.y);
    noFill();
  }
}
