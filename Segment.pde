static class StaticSegment {
   static boolean showLetters = true;
}

class Segment extends StaticSegment{
  
  PVector a;
  PVector b;
  float len;
  float angle;
  int col;
  
  Segment(float x, float y, float angle, float len, int col) {
    this.b = new PVector(x,y);
    this.angle = radians(angle);
    this.len = len;
    this.col = col;
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
  
  void show() {
    stroke(col);
    noFill();
    strokeWeight(4);
    line(a.x, a.y, b.x, b.y);
    circle(b.x,b.y, 16);
    circle(a.x,a.y, 8);
    textSize(24);    
    noStroke();
    if (showLetters){
      printLetter("A",a);
      printLetter("B",b);
    }
  }
  
  void printLetter(String letter, PVector v) {
    fill(51,196);
    circle(v.x+16, v.y+16, 24);
    fill(col);
    text(letter, v.x + 8, v.y + 24);
    noFill();
  }
}
