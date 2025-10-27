import com.prestopy.mrkeyboard.*;

PVector pos1, pos2;
float slowSpeed = 2;
float fastSpeed = 5;
float speed = fastSpeed;
float radius = 50;
MrKeyboard k;
void setup() {
  size(800, 800);
  k = new MrKeyboard(this);
  pos1 = randomPos();
  pos2 = randomPos();
}

void draw() {
  background(0);

  update();

  // We don't want to randomize every frame if R is down
  // Only once when it was pressed
  // So we used isKeyTapped instead of isKeyDown
  if (k.isKeyTapped('r')) {
    pos1 = randomPos();
    pos2 = randomPos();
  }
  if (k.isKeyDown(SHIFT)) speed = slowSpeed;
  else speed = fastSpeed;

  fill(255, 0, 0);
  circle(pos1.x, pos1.y, radius*2);

  fill(0, 255, 0);
  circle(pos2.x, pos2.y, radius*2);

  drawInstructions();
}

PVector randomPos() {
  float x = random(0+radius, width-radius);
  float y = random(0+radius, height-radius);
  return new PVector(x, y);
}

void update() {
  // Notice the 'W' instead of "W"
  // This accepts a CHAR, not a STRING
  if (k.isKeyDown('W')) pos1.y -= speed;
  if (k.isKeyDown('A')) pos1.x -= speed;
  if (k.isKeyDown('S')) pos1.y += speed;
  if (k.isKeyDown('D')) pos1.x += speed;

  // Since up cannot be represented as a char
  // You need to use their keycodes
  // UP, LEFT, DOWN, RIGHT are constants part of Processing
  // They represent the keycodes for their keys
  if (k.isKeyDown(UP)) pos2.y -= speed;
  if (k.isKeyDown(LEFT)) pos2.x -= speed;
  if (k.isKeyDown(DOWN)) pos2.y += speed;
  if (k.isKeyDown(RIGHT)) pos2.x += speed;
}

void drawInstructions() {
  textAlign(LEFT, TOP);
  textSize(64);
  fill(255,0,0);
  text("WASD", 10, 10);
  fill(0,255,0);
  text("↑←↓→", 10, 10+64);

  textSize(32);
  fill(255);
  text("R: randomize", 10, 10+64*2);
  text("SHIFT: slow", 10, 10+64*2+32);
}
