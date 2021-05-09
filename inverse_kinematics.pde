Segment seg;

void setup() {
  size(600,400);
  seg = new Segment(100,100, 180, 75, color(128,255,128));
}

void draw() {
  background(51);
  seg.show();
  seg.follow(mouseX, mouseY);
}
