import com.prestopy.mrkeyboard.*;

MrKeyboard k;

void setup() {
  size(1200, 800);
  k = new MrKeyboard(this); // Initialize Mr. Keyboard for this sketch
  k.startRecording(); // Begin recording key presses
}

void draw() {
  background(0);
  
  // Get the recording
  // getRecording() returns an ArrayList of the recorded key codes
  ArrayList<Integer> recording = k.getRecording();
  
  String str = "";
  // Loop thru all key codes in recording
  for (int i=0; i<recording.size(); i++) {
    // Get the current key code
    int code = recording.get(i);
    
    // BACKSPACE is a Processing constant that represents the key code
    // of the backspace key
    if (code == BACKSPACE) {
      // If the String isn't already empty, remove the last character from it
      if (!str.isEmpty()) str = str.substring(0, str.length()-1);
    }
    else {
      // IMPORTANT: This is a shortcut conversion between key codes and chars
      //            using ASCII codes. It does not work reliably AT ALL
      //            While A thru Z and 0 thru 9 will convert correctly, 
      //            other characters may not work
      char c = (char)code; // int -> char type casting uses ASCII
      str += c;
    }
  }
  
  String textStr = formatStr(str);
  if ((frameCount/30) % 2 == 0) textStr += '|'; // the blinking cursor
  
  fill(255);
  textAlign(LEFT, TOP);
  textSize(30);
  text(textStr, 50, 50);
}

String formatStr(String toFormat) {
  // Format the string
  String textStr = "";
  int maxLines = 20;
  
  // Array of lines from the String
  // E.g., "Hello
  //       Ni hao"
  //       Will become ["Hello", "Ni hao"]
  // \n represents the newline character
  // (invisible character that denotes next lines)
  String[] lines = toFormat.split("\n", -1);
 
  // Limit it to the last 20 lines
  // Loop thru the array backwards
  //         index of last line       the line to stop at
  for (int i=lines.length-1;     i >= max(0, lines.length-maxLines); i--) {
    // If it isn't the last line, newline at the start
     if (i != max(0, lines.length-maxLines)) textStr = "\n" + lines[i] + textStr;
     else textStr = lines[i] + textStr;
  }
  
  return textStr;
}
