import sprites.*;
import sprites.utils.*;
import sprites.maths.*;
import java.util.*;
import java.util.concurrent.*;

GameLevel currentGameLevel; 
PImage background;

KeyboardController kbController;
SoundPlayer soundPlayer;
StopWatch stopWatch = new StopWatch();
int totalLives = 3;
int remainingLives;
float globalVolume = .2;

boolean startButtonRegistered = false;
boolean isPaused = false; // Track the pause state

void setup() {
  size(1000, 700);

  // BG Image must be same size as window. 
  background = loadImage("bg.jpg");

  kbController = new KeyboardController();
  soundPlayer = new SoundPlayer(this, globalVolume);  

  currentGameLevel = new StartLevel(this);
  currentGameLevel.start();

  // Register the function (pre) that will be called
  // by Processing before the draw() function. 
  registerMethod("pre", this);
}

// Executed before each next frame is drawn. 
void pre() {
  nextLevelStateMachine();
}

// New method to handle pausing and resuming the game
void togglePause() {
  isPaused = !isPaused; // Toggle pause state
}

// Draw the pause button on the screen
void drawPauseButton() {
  fill(255); // White color for the button
  rect(width - 110, 20, 100, 50, 10); // Draw the button rectangle
  fill(0); // Black color for the text
  textSize(20);
  textAlign(CENTER, CENTER);
  text(isPaused ? "Resume" : "Pause", width - 60, 45); // Button text
}

// Determine if the current GameLevel is finished
// and which new GameLevel is next. 
void nextLevelStateMachine() {
  GameState state = currentGameLevel.getGameState();

  if (currentGameLevel instanceof StartLevel) {
    if (state == GameState.Finished) {
      currentGameLevel.stop(); // Stop the current GameLevel
      currentGameLevel = new AsteroidsLevel1(this); // Set the next GameLevel
      currentGameLevel.start(); // Start the new GameLevel
    }
  } else if (currentGameLevel instanceof AsteroidsLevel1) {
    if (state == GameState.Finished) {
      currentGameLevel.stop();
      currentGameLevel = new AsteroidsLevel2(this);
      currentGameLevel.start();
    } else if (state == GameState.Lost) {
      currentGameLevel.stop();
      currentGameLevel = new LoseLevel(this);
      currentGameLevel.start();
    }
  } else if (currentGameLevel instanceof AsteroidsLevel2) {
    if (state == GameState.Finished) {
      currentGameLevel.stop();
      currentGameLevel = new WinLevel(this);
      currentGameLevel.start();
    } else if (state == GameState.Lost) {
      currentGameLevel.stop();
      currentGameLevel = new LoseLevel(this);
      currentGameLevel.start();
    }
  } else if (currentGameLevel instanceof WinLevel) {
    if (state == GameState.Finished) {
      currentGameLevel.stop();
      currentGameLevel = new StartLevel(this);
      currentGameLevel.start();
    }
  } else if (currentGameLevel instanceof LoseLevel) {
    if (state == GameState.Finished) {
      currentGameLevel.stop();
      currentGameLevel = new StartLevel(this);
      currentGameLevel.start();
    }
  }
}

// Activated by Processing when a key is pressed
void keyPressed() {
  currentGameLevel.keyPressed();
  kbController.keyPressed(keyCode, key);
}

void keyReleased() {
  kbController.keyReleased(keyCode, key);
}

// Activated by Processing when the mouse button is pressed in the canvas
void mousePressed() {
  // Check if the pause button is clicked
  if (mouseX >= width - 110 && mouseX <= width - 10 && mouseY >= 20 && mouseY <= 70) {
    togglePause(); // Toggle pause state when button is clicked
  }
  currentGameLevel.mousePressed();
}

void draw() {
  background(0); // Set background to default black
  
  currentGameLevel.drawBackground();
  
  if (!isPaused) {
      currentGameLevel.update(); // Only update game state if not paused
      S4P.updateSprites(stopWatch.getElapsedTime()); // Update sprites
  }

  S4P.drawSprites(); // Draw sprites regardless of pause state
  currentGameLevel.drawOnScreen();

  drawPauseButton(); // Draw the pause button

  // Optional: Draw pause indicator
  if (isPaused) {
    fill(255, 0, 0);
    textSize(50);
    textAlign(CENTER);
    text("PAUSED", width / 2, height / 2);
  }
}

void stop() {
    if (soundPlayer != null) {
        soundPlayer.stop(); // Ensure to stop all sounds
    }
    super.stop(); // Call the superclass stop method
}
