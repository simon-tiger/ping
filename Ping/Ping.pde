PApplet sketch = this;

Ball ball;
Paddle paddleA;
Paddle paddleB;
float startTime;
float resetDelay;
float timediff;
Pointer pointer;
int bounces = 0;
boolean gamestart = true;

// Use this function to perform your initial setup
void setup() {
  size(749, 768);
  
  reset(null);        // reset the game state
  resetDelay = 360;  // time until the ball moves without user intervention
  
  paddleA = new Paddle(width/2, height - 40, color(0, 158, 255, 255), "Blue");
  paddleB = new Paddle(width/2, 60, color(0, 255, 158, 255), "Green");
}

void reset(Paddle paddle) {
  startTime = millis() / 1000;
  resetDelay = 2;            // 2 second delay until the ball moves
  
  if (ball == null) ball = new Ball();     // create a ball if one doesn't exist
  ball.position = new PVector(width/2, height/2);
  
  // set up the ball angle indicator
  String direction = null;
  if (paddle == null) {
    direction = randomDirection();
  } else if (paddle == paddleA) {
    direction = "down";
  } else if (paddle == paddleB) {
    direction = "up";
  }
  pointer = new Pointer(direction);
}

// one player has scored a point
void score(Paddle paddle) {
  paddle.score = paddle.score + 1;
  reset(paddle);
  
  if (paddle.score == 5) {
    win(paddle);
  }
}

void win(Paddle paddle) {
  println(paddle.name + " wins!");
  resetDelay = 360;
  gamestart = true;
  paddleA.position.x = width / 2;
  paddleB.position.x = width / 2;
}

// This function gets called once every frame
void draw() {
  update();
  
  background(35, 40, 70, 255);
  
  strokeWeight(2);
  stroke(70, 86, 129, 39);
  line(0, height / 2, width, height / 2);
  
  if (pointer != null && resetDelay <= 2) pointer.draw();
  
  drawScores();
  paddleA.draw();
  paddleB.draw();
  ball.draw();
}

void update() {
  // if the game is being reset, then either do nothing or just update the angle pointer
  if (resetDelay > 0) {
    timediff = millis() / 1000 - startTime;
    if (timediff < resetDelay) {
      return;
    } else {
      ball.setAngle(pointer.angle);
      pointer = null;
      resetDelay = 0;
    }
  }
  
  ball.update();
  
  // check for collisions
  if (paddleA.collide(ball)) {
    bounces = bounces + 1;
    paddleA.rebound(ball);
  } else if (paddleB.collide(ball)) {
    bounces = bounces + 1;
    paddleB.rebound(ball);
  }
  
  // every 5 bounces, increase speed!
  if (bounces == 5) {
    ball.increaseSpeed();
    bounces = 0;
  }
}

void mousePressed() {
  if (gamestart == true) {
    reset(null);
    gamestart = false;
    paddleA.score = 0;
    paddleB.score = 0;
  }
}

void mouseDragged() {
  int deltaX = mouseX - pmouseX;
  
  if (mouseY > height/2) {
    paddleA.moveX(deltaX);
  } else if (mouseY < height/2) {
    paddleB.moveX(deltaX);
  }
}

void drawScores() {
  // bottom
  for (int i=1;i<=paddleA.score;i = i + 1) {
    pushStyle();
    strokeWeight(2);
    stroke(255,255,255,255);
    fill(paddleA.colour);
    rect(12, (height / 2) + 24*i - 12, 12, 12);
    popStyle();
  }
  // top
  for (int i=1;i<=paddleB.score;i = i + 1) {
    pushStyle();
    strokeWeight(2);
    stroke(255,255,255,255);
    fill(paddleB.colour);
    rect(12, (height / 2) - 24*i, 12, 12);
    popStyle();
  }
}

// select a random player for the ball to aim at
String randomDirection() {
  int i = round(random(1));
  if (i == 0) {
    return "up";
  } else {
    return "down";
  }
}