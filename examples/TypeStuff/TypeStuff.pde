import com.prestopy.mrkeyboard.*;
MrKeyboard k;

void setup() {
  size(800, 800);
  k = new MrKeyboard(this);
  k.startRecording();
  // fullScreen();
}

void draw() {
  background(0);
  String str = "";
  for (int k : k.getRecording()) {
    if (k == 8) { // BACKSPACE
      str.substring(0, str.length()-1);
    } else {
      char ch = (char)k; // not a perfect conversion at all
      str += ch;
    }
  }
  
  fill(255);
  textAlign(CENTER, CENTER);
  text(str, width/2, height/2);
}
