import com.prestopy.mrkeyboard.*;

PVector pos1, pos2;
float slowSpeed = 2;
float fastSpeed = 5;
float speed = fastSpeed;
float radius = 50;
MrKeyboard k;
void setup() {
  size(800, 800);
  k = new MrKeyboard(this); // Initialize with the current sketch
  pos1 = randomPos();
  pos2 = randomPos();
}

void draw() {
  background(0);

  update();

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
  // isKeyDown accepts a CHAR, not a STRING
  PVector v1 = new PVector();
  if (k.isKeyDown('W')) v1.y -= 1;
  if (k.isKeyDown('A')) v1.x -= 1;
  if (k.isKeyDown('S')) v1.y += 1;
  if (k.isKeyDown('D')) v1.x += 1;
  v1.setMag(speed); // Ensure the speed remains constant if two directions are pressed
                    // E.g., UP & LEFT would normally result in speed of 1 up and 1 left
                    //       Or square root 2 (pythagorean thm.) in the
                    //       up-left direction which is faster than the 
                    //       speed of 1
                    //       To fix this, we set the magnitude (length) 
                    //       of the vector directly
  pos1.add(v1);
  
  // Since up cannot be represented as a char
  // You need to use their keycodes
  // UP, LEFT, DOWN, RIGHT are constants part of Processing
  // They represent the keycodes for their keys
  PVector v2 = new PVector();
  if (k.isKeyDown(UP)) v2.y -= 1;
  if (k.isKeyDown(LEFT)) v2.x -= 1;
  if (k.isKeyDown(DOWN)) v2.y += 1;
  if (k.isKeyDown(RIGHT)) v2.x += 1;
  v2.setMag(speed);
  pos2.add(v2);
  
  // We don't want to randomize every frame if R is down
  // Only once when it was pressed
  // So we used isKeyTapped instead of isKeyDown
  if (k.isKeyTapped('r')) {
    pos1 = randomPos();
    pos2 = randomPos();
  }
  
  // We can use if/else to toggle an option while a key is pressed
  if (k.isKeyDown(SHIFT)) speed = slowSpeed;
  else speed = fastSpeed;
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
