class Leg {

  Segment[] segments;
  int segmentCount = 20;
  PVector base = new PVector(450,300);
  
  color[] colors = {
    color(255,128,128),
    color(255,255,128),
    color(128,255,128),
    color(128,255,255),
    color(128,128,255),
    color(255,255,128)
  };
  
  Leg(int segmentCount, float sx, float sy, float ex, float ey) {
    this.segmentCount = segmentCount;
    segments = new Segment[segmentCount];
    PVector start = new PVector(sx, sy);
    PVector end = new PVector(ex, ey);
    float angle = PVector.sub(end, start).heading();
    float fullLength = PVector.sub(start, end).mag();
    float singleLength = fullLength / segmentCount;
    PVector segmentDelta = PVector.sub(end, start).div(segmentCount);
    
    for(int i = 0; i < segmentCount; i++) {
      float segmentEndX = segmentDelta.x * (i + 1);
      float segmentEndY = segmentDelta.y * (i + 1);
      color col = colors[i % colors.length];
      segments[i] = new Segment(i, sx+segmentEndX, sy+segmentEndY, angle, singleLength, col);
    }

  }
  
  void show() {
    for (int i = 0; i < segmentCount; i++) {
      segments[i].show();
    }
  }
  
  void follow(float targetX, float targetY) {
    
    PVector followVector = new PVector(targetX, targetY);
    for (int i = segmentCount - 1; i >= 0; i--) {
      segments[i].follow(followVector.x, followVector.y);
      followVector = segments[i].a;
    }
    
    PVector currentBase = base;
    for (int i = 0; i < segmentCount; i++) {
      segments[i].setBase(currentBase.x, currentBase.y);
      currentBase = segments[i].b;
    }
  }
}
