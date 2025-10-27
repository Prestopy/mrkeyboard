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

    /**
     * Constructs a Mr. Keyboard class for the given PApplet.
     * @param app The PApplet to attach listeners to
     */
    public MrKeyboard(PApplet app) {
        parent = app;
        keysDown = new HashSet<>();
        keysPressedBlacklist = new HashSet<>();
        recordKeys = false;
        recordedKeys = new ArrayList<>();

        parent.registerMethod("keyEvent", this);
    }

    /**
     * Checks whether a specific key (by key code) is currently pressed.
     *
     * @param kCode The key code
     * @return True if the key is down. False otherwise.
     */
    public boolean isKeyDown(int kCode) {
        return keysDown.contains(kCode);
    }

    /**
     * Checks whether a specific key (by character) is currently pressed.
     *
     * @param k The character
     * @return True if the key is down. False otherwise.
     */
    public boolean isKeyDown(char k) {
        int kCode = java.awt.event.KeyEvent.getExtendedKeyCodeForChar(k);
        return isKeyDown(kCode);
    }

    /**
     * Detects a single key tap without repetition. A 'key tap' is triggered once per press and won't repeat until the
     * key is released and pressed again. This method is polling-based, not event-driven- it checks the key state when
     * called. If the key is currently held down, the method returns true the first time it’s called after the press,
     * and false on subsequent calls until the key is released.
     *
     * @param kCode The key code
     * @return True if the key is tapped. False otherwise.
     */
    public boolean isKeyTapped(int kCode) {
        if (keysDown.contains(kCode) && !keysPressedBlacklist.contains(kCode)) {
            keysPressedBlacklist.add(kCode);
            return true;
        }

        return false;
    }

    /**
     * Detects a single key tap without repetition. A 'key tap' is triggered once per press and won't repeat until the
     * key is released and pressed again. This method is polling-based, not event-driven- it checks the key state when
     * called. If the key is currently held down, the method returns true the first time it’s called after the press,
     * and false on subsequent calls until the key is released.
     *
     * @param k The character
     * @return True if the key is tapped. False otherwise.
     */
    public boolean isKeyTapped(char k) {
        int kCode = java.awt.event.KeyEvent.getExtendedKeyCodeForChar(k);
        return isKeyTapped(kCode);
    }

    /**
     * Checks if currently recording key events.
     *
     * @return True if recording. False otherwise.
     */
    public boolean isRecording() {
        return recordKeys;
    }

    /**
     * Returns the recording, a list of key codes of the keys down while recording was true
     *
     * @return list of key codes of the keys recorded
     */
    public ArrayList<Integer> getRecording() {
        return recordedKeys;
    }

    /**
     * Start recording.
     */
    public void startRecording() {
        recordKeys = true;
    }

    /**
     * End recording.
     */
    public void endRecording() {
        recordKeys = false;
    }

    /**
     * Clear the recording.
     */
    public void clearRecording() {
        recordedKeys.clear();
    }

    /**
     * Gets a set of all the keys down at the given moment.
     *
     * @return A HashSet containing a list of key codes.
     */
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
