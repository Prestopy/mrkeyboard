# Mr. Keyboard
Mr. Keyboard is a simple library designed to make it easier to use keyboard events in Processing.

# Installation

After installing the library in your Processing sketchbook, import and use the library with:
```java
import com.prestopy.mrkeyboard.*;
MrKeyboard k;

void setup() {
   k = new MrKeyboard(this); // pass the PApplet
}
```
That's it. Cool :)


# Docs
## Constructor
`MrKeyboard(PApplet app)`<br /><br />
Initializes the keyboard handler and registers with the provided Processing applet

**Parameters:**
- `app` - the parent `PApplet` instance to register the keyboard event listner with.

## `HashSet<Integer> getKeysDown()`
Gets a set of all the keys down at the given moment.

**Returns:**
- A `HashSet` containing a list of key codes in the `Integer` type

## `boolean isKeyDown(int kCode)`
Checks whether a specific key (by key code) is currently pressed.

**Parameters:**
- `kCode` - integer with the key code see [`java.awt.events.KeyEvent`](https://docs.oracle.com/javase/8/docs/api/java/awt/event/KeyEvent.html)

**Returns:**
- `true` if the key is down. `false` otherwise

## `boolean isKeyDown(char k)`

**Parameters:**
- `k` - character to check

**Returns:**
- `true` if the key is down. `false` otherwise

## `boolean isKeyTapped(int kCode)`
Detects a single key tap without repetition. A 'key tap' is triggered once per press and won't repeat until the key is released and pressed again. This method is polling-based, not event-driven- it checks the key state when called. If the key is currently held down, the method returns `true` the first time it’s called after the press, and `false` on subsequent calls until the key is released.

**Parameters:**
- `k` - character to check

**Returns:**
- `true` if the key is tapped. `false` otherwise

## `boolean isKeyTapped(char k)`

**Parameters:**
- `k` - character to check

**Returns:**
- `true` if the key is tapped. `false` otherwise

---
## Recording
You can record and save key events as they happen with the `startRecording()`, `endRecording()`, `clearRecording()`, and `getRecording()` methods.
### Example
```java
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
      char ch = (char)k; // !!! not a perfect conversion from keycodes to characters
      str += ch;
    }
  }
  
  fill(255);
  textAlign(CENTER, CENTER);
  text(str, width/2, height/2);
}
```
