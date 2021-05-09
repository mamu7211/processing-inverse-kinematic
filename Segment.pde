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

  Segment(int segmentNumber, float x, float y, float angle, float len, int col) {
    this.b = new PVector(x, y);
    this.angle = angle;
    this.len = len;
    this.col = col;
    this.segmentNumber = segmentNumber;
    calculateA();
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
  
  void setBase(float baseX, float baseY) {
    PVector direction = PVector.sub(b, a);
    a = new PVector(baseX, baseY);
    b = PVector.add(a, direction);
  }

  void show() {
    stroke(col);
    noFill();
    strokeWeight(4);
    line(a.x, a.y, b.x, b.y);
    circle(b.x, b.y, 16);
    circle(a.x, a.y, 8);
    noStroke();
    if (showLetters) {
      printLetter("A", a, -1.0);
      printLetter("B", b, 1.0);
    }
  }

  void printLetter(String letter, PVector v, float dir) {
    fill(51, 196);
    float diameter = 32.0;
    textSize(diameter / 2.0);    
    PVector offs = new PVector(22,20).mult(dir);
    PVector pvCircle = new PVector(v.x, v.y).add(offs);
    PVector pvText = new PVector(v.x - diameter / 2.0 + 8.0, v.y + 8.0).add(offs);
    circle(pvCircle.x, pvCircle.y, diameter);
    fill(col);
    String indicator = String.format("%s%d", letter, segmentNumber);
    text(indicator, pvText.x, pvText.y);
    noFill();
  }
}
