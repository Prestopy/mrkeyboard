package com.prestopy.mrkeyboard;

import processing.core.PApplet;
import processing.event.KeyEvent;

import java.util.ArrayList;
import java.util.HashSet;

public class MrKeyboard {
  private HashSet<Integer> keysDown;
  private HashSet<Integer> keysPressedBlacklist;
  private boolean recordKeys;
  private ArrayList<Integer> recordedKeys;
  PApplet parent;

  public MrKeyboard(PApplet app) {
    parent = app;
    keysDown = new HashSet<>();
    keysPressedBlacklist = new HashSet<>();
    recordKeys = false;
    recordedKeys = new ArrayList<>();

    parent.registerMethod("keyEvent", this);
  }

  public boolean isKeyDown(int kCode) {
    return keysDown.contains(kCode);
  }
  public boolean isKeyDown(char k) {
    int kCode = java.awt.event.KeyEvent.getExtendedKeyCodeForChar(k);
    return isKeyDown(kCode);
  }
  
  // No repeats
  public boolean isKeyTapped(int kCode) {
    if (keysDown.contains(kCode) && !keysPressedBlacklist.contains(kCode)) {
      keysPressedBlacklist.add(kCode);
      return true;
    }
    
    return false;
  }
  public boolean isKeyTapped(char k) {
    int kCode = java.awt.event.KeyEvent.getExtendedKeyCodeForChar(k);
    return isKeyTapped(kCode);
  }

  public boolean isRecording() {
    return recordKeys;
  }
  public ArrayList<Integer> getRecording() {
    return recordedKeys;
  }
  public void startRecording() {
    recordKeys = true;
  }
  public void endRecording() {
    recordKeys = false;
  }
  public void clearRecording() {
    recordedKeys.clear();
  }
  
  HashSet<Integer> getKeysDown() {
    return keysDown;
  }
  
  public void keyEvent(processing.event.KeyEvent event) {
    if (event.getAction() == KeyEvent.PRESS) {
      keysDown.add(event.getKeyCode());

      if (isRecording()) recordedKeys.add(event.getKeyCode());
    } else if (event.getAction() == KeyEvent.RELEASE) {
      keysDown.remove(event.getKeyCode());
      keysPressedBlacklist.remove(event.getKeyCode());
    }
  }
}
