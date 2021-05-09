class Leg {

  Segment[] segments = new Segment[3];
  int segmentCount = 3;
  
  color[] colors = {
    color(128,256,128),
    color(256,256,128),
    color(128,128,256),
  };
  
  Leg(float sx, float sy, float ex, float ey) {
    
    PVector start = new PVector(sx, sy);
    PVector end = new PVector(ex, ey);
    float angle = PVector.sub(end, start).heading();
    float fullLength = PVector.sub(start, end).mag();
    float singleLength = fullLength / segmentCount;
    PVector segmentDelta = PVector.sub(end, start).div(segmentCount);
    
    for(int i = 0; i < segmentCount; i++) {
      float segmentEndX = segmentDelta.x * (i + 1);
      float segmentEndY = segmentDelta.y * (i + 1);
      segments[i] = new Segment(i, sx+segmentEndX, sy+segmentEndY, angle, singleLength, colors[i]);
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
  }
}
