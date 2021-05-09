Leg leg;

void setup() {
  StaticSegment.showLetters = true;
  size(900,600);
  leg = new Leg(100,100,200,500);
}

void draw() {
  background(51);
  leg.show();
  leg.follow(mouseX, mouseY);
}
