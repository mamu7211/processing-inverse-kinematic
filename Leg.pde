class Leg {

  Leg(float sx, float sy, float ex, float ey) {
    PVector start = new PVector(sx, sy);
    PVector end = new PVector(ex, ey);
    float angle = PVector.angleBetween(start, end);
    float fullLength = PVector.sub(start,end).mag();
  }
}
