Leg leg;

void setup() {
  StaticSegment.showLetters = true;
  size(1600,1200);
  leg = new Leg(2, 0, 0, 0, width/3-50);
  leg.base = new PVector(width/2, height).mult(0.5);
  
  leg.segments[0].setConstraint(-PI/2.0,PI/2.0);
  //leg.segments[1].setConstraint(radians(-20), radians(160));
  //leg.segments[2].setConstraint(radians(-45), radians(45));
}

void draw() {
  background(51);
  leg.show();
  leg.follow(mouseX, mouseY);
}
