class Pointer {
  PVector origin;
  float length;
  String direction;
  float angle;
  float speed;
  
  // Pointer is the ball direction pointer that appears before each round
  Pointer(String direction) {
    origin = new PVector(width/2, height/2);
    length = 50;
    this.direction = direction;
    if (this.direction == "up") {
      angle = random(135, 225);
    } else {
      angle = random(315, 405);
    }
    speed = -2;
  }
  
  void update() {
    angle = angle + speed;
    
    // reverse direction if the angle is too far to either side
    if (direction == "up") {
      if (angle <= 135 || angle >= 225) speed = speed * -1;
    } else {
      if (angle == 314 || (angle >= 45 && angle < 314)) speed = speed * -1;
    }
    
    // if the angle passes over 360, or below 0, wrap it round
    if (angle < 0) {
      angle = 360 - angle;
    } else if (angle > 360) {
      angle = angle - 360;
    }
  }
  
  void draw() {
    update();
    
    // calculate the new endpoints of the line based on the angle and length
    PVector endpoint = new PVector();
    endpoint.x = length * sin(radians(angle)) + origin.x;
    endpoint.y = length * cos(radians(angle)) + origin.y;
    
    pushStyle();
    
    strokeWeight(1);
    stroke(255, 255, 255, 255);
    line(origin.x, origin.y, endpoint.x, endpoint.y);
    
    popStyle();
  }
}