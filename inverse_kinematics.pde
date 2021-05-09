Leg leg;

void setup() {
  StaticSegment.showLetters = true;
  size(1600,1200);
  leg = new Leg(5, 0, 0, 0,width/2-50);
  leg.base = new PVector(width, height).mult(0.5);
}

void draw() {
  background(51);
  leg.show();
  leg.follow(mouseX, mouseY);
}
