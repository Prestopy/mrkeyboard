import com.prestopy.mrkeyboard.*;
MrKeyboard k;
boolean gameOver = false;
boolean win = false;

// The user's guesses
String[] strs = new String[5];
// The guess the user is on (1st guess, etc.)
int stage = 0;
// The results of each guess
String[] verdict = new String[5];
// Word bank
String[] words = {
    "apple", "bread", "chair", "dream", "eagle",
    "flame", "grape", "house", "image", "jelly",
    "knock", "lemon", "magic", "noble", "ocean",
    "pearl", "queen", "river", "snake", "table",
    "urban", "vivid", "wheat", "xenon", "youth", "zebra"
};
// Answer for this game
String answer;

void setup() {
  size(800, 800);
  k = new MrKeyboard(this); // Initialize Mr. Keyboard with this
  
  // Begin recording all key presses in this sketch
  // This will allow us to easily keep track of what
  // the player typed for each guess
  k.startRecording();
  
  // Fill strs & verdict with empty strings
  for (int i=0; i<strs.length; i++) strs[i] = "";
  for (int i=0; i<verdict.length; i++) verdict[i] = "";
  
  // Pick a random word
  answer = words[int(random(words.length))];
  
  strokeWeight(5);
  textAlign(CENTER, CENTER);
}

// Padding between squares
int padding = 50;
// Square dimensions
int dim = 100;

void draw() {
  background(0);
  
  if (gameOver) {
    if (win) background(0, 255, 0);
    else {
      background(255, 0, 0);
      textSize(24);
      fill(255);
      text("The answer was " + answer.toUpperCase(), width/2, height-padding/2);
    }
  } else recordKeyPresses(); // While the game isn't over, accept key presses
  
  // Loop thru all guesses
  for (int i=0; i<strs.length; i++) {
    // Loop thru all characters of the current guess
    for (int j=0; j<5; j++) {
      if (!verdict[i].isEmpty()) {
        // Since there is a verdict (it isn't empty)
        // We can fill the colors based on those
        char currV = verdict[i].charAt(j);
        if (currV == 'C') fill(0, 255, 0); // Correct
        if (currV == 'W') fill(255, 100, 0); // Wrong position
        if (currV == 'X') fill(100); // Not in word
      } else fill(255);
      
      // Add border to the box row for the player's current guess
      if (stage == i && !gameOver) stroke(255,0,0);
      else noStroke();
      rect(padding+(dim+padding)*j, padding+(dim+padding)*i, dim, dim);
      
      // The stage this row represents (first guess, second guess, etc.)
      String currStage = strs[i];
      
      // If this box contains a letter
      if (j < currStage.length()) {
        // The letter this box represents
        char letter = currStage.charAt(j);

        fill(0);
        textSize(32);
        text(letter, padding+(dim+padding)*j+dim/2, padding+(dim+padding)*i+dim/2);
      }
    }
  }
  
  // We use isKeyDown to check if the enter key was pressed
  // ENTER is a constant in Processing that represents the key code
  // for the enter key
  if (k.isKeyDown(ENTER) && strs[stage].length() == 5) {
    verdict[stage] = check(answer, strs[stage]);
    // If the user is correct (the guess equals the answer)
    if (strs[stage].equals(answer.toUpperCase())) {
      // The player is all correct
      gameOver = true;
      win = true;
      return;
    }
    
    // If the stage is less than 4, increment it
    // We use less than 4 so that the maximum stage is 4.
    if (stage < 4) stage++;
    else {
      // The player exhausted all guesses
      gameOver = true;
    }
    
    // Clear the recording for the next guess
    k.clearRecording();
  }
}

void recordKeyPresses() {
  // Get the recorded key presses
  // getRecording() returns an ArrayList of the key codes recorded
  ArrayList<Integer> recording = k.getRecording();
  strs[stage] = "";
  
  for (int i=0; i<recording.size(); i++) {
    // 65 thru 90 are the keycodes for 'A' thru 'Z'
    // Since we only want to accept letters, we will only add
    // Keycodes between 65 and 90 to the string
    int code = recording.get(i);
    if (code >= 65 && code <= 90) {
      // IMPORTANT: Key code -> char conversion only works relaibly with letters
      char letter = (char)code;
      
      if (strs[stage].length() < 5) strs[stage] += letter;
    }
    
    // If the key pressed is the backspace, delete the last character pressed
    // BACKSPACE is a Processing constant representing the key code for the backspace key
    if (code == BACKSPACE && !strs[stage].isEmpty()) {
      strs[stage] = strs[stage].substring(0, strs[stage].length()-1);
    }
  }
}

// Helper method that returns the result of the guess
String check(String ans, String str) {
  String result = "";
  ans = ans.toUpperCase();
  
  for (int i=0; i<str.length(); i++) {
    char currentChar = str.charAt(i);
    if (currentChar == ans.charAt(i)) result += 'C'; // correct
    else if (ans.indexOf(currentChar) >= 0) {
      // It exists in the word. Just not in this position
      int idx = ans.indexOf(currentChar);
      // Set the char to # to avoid repeated checks on it
      // E.g., if the word is HELLO and the player guesses TREES
      //       TREES has two Es so the first will match the first E in HELLO
      //       The second will have nothing to match (the matched E in HELLO is now #)
      //       and will correctly be judged as not in the word
      ans = ans.substring(0, idx) + '#' + ans.substring(idx+1);
      result += 'W'; // wrong pos
    } else {
      result += 'X'; // not in word
    }
  }
  
  return result;
}
