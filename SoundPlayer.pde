import ddf.minim.*; // Import the Minim library

class SoundPlayer {
    Minim minim; // Minim instance for managing sound
    AudioPlayer boomPlayer, popPlayer, gameOverPlayer;
    AudioPlayer explosionLargeAsteroid, explosionShip, explosionSmallAsteroid;
    AudioPlayer ohYea, missileLaunch;

    SoundPlayer(PApplet app, float globalVolume) {
        minim = new Minim(app); // Initialize Minim

        // Load sound files
        boomPlayer = minim.loadFile("explosionSound.mp3"); // New explosion sound
        boomPlayer.setGain(globalVolume); // Set volume (in dB)

        gameOverPlayer = minim.loadFile("GameOver3.mp3"); // New game over sound
        gameOverPlayer.setGain(globalVolume);

        popPlayer = minim.loadFile("pop.mp3"); // New pop sound
        popPlayer.setGain(globalVolume);

        explosionLargeAsteroid = minim.loadFile("BigExplosion.mp3"); // New large asteroid explosion sound
        explosionLargeAsteroid.setGain(globalVolume);

        explosionSmallAsteroid = minim.loadFile("SmallExplosion.mp3"); // New small asteroid explosion sound
        explosionSmallAsteroid.setGain(globalVolume);

        explosionShip = minim.loadFile("ShipExplosion.mp3"); // New ship explosion sound
        explosionShip.setGain(globalVolume);

        ohYea = minim.loadFile("Applause.mp3"); // New "Oh Yeah" sound
        ohYea.setGain(globalVolume);

        missileLaunch = minim.loadFile("MissileLaunch.mp3"); // New missile launch sound
        missileLaunch.setGain(globalVolume);
    }

    void playExplosion() {
        boomPlayer.rewind(); // Rewind before playing
        boomPlayer.play();
    }

    void playPop() {
        popPlayer.rewind();
        popPlayer.play();
    }

    void playGameOver() {
        gameOverPlayer.rewind();
        gameOverPlayer.play();
    }

    void playExplosionLargeAsteroid() {
        explosionLargeAsteroid.rewind();
        explosionLargeAsteroid.play();
    }

    void playExplosionSmallAsteroid() {
        explosionSmallAsteroid.rewind();
        explosionSmallAsteroid.play();
    }

    void playExplosionShip() {
        explosionShip.rewind();
        explosionShip.play();
    }

    void playOhYea() {
        ohYea.rewind();
        ohYea.play();
    }

    void playMissileLaunch() {
        missileLaunch.rewind();
        missileLaunch.play();
    }

    void stop() {
        // Stop all audio players
        if (boomPlayer != null) boomPlayer.close();
        if (popPlayer != null) popPlayer.close();
        if (gameOverPlayer != null) gameOverPlayer.close();
        if (explosionLargeAsteroid != null) explosionLargeAsteroid.close();
        if (explosionSmallAsteroid != null) explosionSmallAsteroid.close();
        if (explosionShip != null) explosionShip.close();
        if (ohYea != null) ohYea.close();
        if (missileLaunch != null) missileLaunch.close();

        if (minim != null) minim.stop(); // Stop Minim and release resources
    }
}
