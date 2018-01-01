class Paddle {
  PVector position;
  color colour;
  float width;
  float height;
  int score;
  String name;
  
  Paddle(float x, float y, color colour, String name) {
    position = new PVector(x, y);
    this.colour = colour;
    width = 100;
    height = 20;
    score = 0;
    this.name = name;
  }
  
  void draw() {
    pushStyle();
    
    strokeWeight(3);
    stroke(255, 255, 255, 255);
    fill(colour);
    rect(position.x - halfwidth(), position.y - height, width, height);
    
    popStyle();
  }
  
  void moveX(float deltaX) {
    position.x = position.x + deltaX;
    if (position.x < halfwidth()) position.x = halfwidth();
    else if (position.x > sketch.width - halfwidth()) {
      position.x = sketch.width - halfwidth();
    }
  }
  
  // basic rectangle collision check
  boolean collide(Ball ball) {
    if (ball.right() > left() &&
         ball.left() < right() &&
         ball.top() < bottom() &&
         ball.bottom() > top()) {
      return true;
    }
    
    return false;
  }
  
  void rebound(Ball ball) {
    // which direction do we need to resolve the collision?
    float yup = abs(ball.bottom() - top());
    float ydown = abs(ball.top() - bottom());
    
    // vertical collision
    if (yup < ydown) {
      ball.position.y = ball.position.y - yup;
    } else {
      ball.position.y = ball.position.y + ydown;
    }
    ball.speed.y = ball.speed.y * -1;
  }
  
  // some useful functions to help when doing collisions
  float halfwidth() {
    return width / 2;
  }
  
  PVector center() {
    return new PVector(position.x, position.y + height / 2);
  }
  
  float left() {
    return position.x - halfwidth();
  }
  
  float right() {
    return position.x + halfwidth();
  }
  
  float top() {
    return position.y - height;
  }
  
  float bottom() {
    return position.y;
  }
}