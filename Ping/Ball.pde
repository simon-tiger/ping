float INITIAL_SPEED = 7;

class Ball {
  PVector position;
  PVector speed;
  float direction;
  float diameter;
  float angle;
  
  Ball() {
    position = new PVector(width/2, height/2);
    speed = new PVector(INITIAL_SPEED, -INITIAL_SPEED);
    direction = 1;
    diameter = 20;
    angle = 180;
  }
  
  void update() {
    // update x and y position based on current speed
    position.x = position.x + speed.x;
    position.y = position.y + speed.y;
    keepInScreen();
  }
  
  void draw() {
    pushStyle();
    
    noStroke();
    fill(255, 255, 255, 255);
    rectMode(CENTER);
    rect(position.x, position.y, diameter, diameter);
    
    popStyle();
  }
  
  void setAngle(float a) {
    angle = a;
    float x = INITIAL_SPEED * sin(radians(angle));
    float y = INITIAL_SPEED * cos(radians(angle));
    speed = new PVector(x, y);
  }
  
  void increaseSpeed() {
    if (speed.x < 0) speed.x = speed.x - 1;
    if (speed.x > 0) speed.x = speed.x + 1;
    if (speed.y < 0) speed.y = speed.y - 1;
    if (speed.y > 0) speed.y = speed.y + 1;
  }
  
  void keepInScreen() {
    float radius = radius();
    
    if (position.x > width - radius) {
      // if the ball has hit the right side
      position.x = width - radius;
      speed.x = speed.x * -1;
    } else if (position.x < radius) {
      // or if it's hit the left side
      position.x = radius;
      speed.x = speed.x * -1;
    }
    
    if (position.y < 0) {
      score(paddleA);
    } else if (position.y > height) {
      score(paddleB);
    }
  }
  
  // some useful functions to help when doing collisions
  float radius() {
    return diameter / 2;
  }
  
  float left() {
    return position.x - radius();
  }
  
  float right() {
    return position.x + radius();
  }
  
  float top() {
    return position.y - radius();
  }
  
  float bottom() {
    return position.y + radius();
  }
}