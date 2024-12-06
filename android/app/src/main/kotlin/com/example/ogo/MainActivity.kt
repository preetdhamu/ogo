package com.example.ogo
import android.content.Context
import android.content.Intent
import android.content.ContentResolver 
import android.media.AudioManager
import android.os.Build
import android.provider.Settings
import android.util.Rational
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "pip_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Set up the MethodChannel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "enterPiP" -> {
                        startPictureInPictureMode()  // PiP Mode
                        result.success(null)
                    }
                    "setBrightness" -> {
                        val brightness = call.argument<Double>("brightness") ?: 0.5
                        setScreenBrightness(brightness.toFloat())
                        result.success(null)
                    }
                    "setVolume" -> {
                        val volume = call.argument<Int>("volume") ?: 50
                        setSystemVolume(volume)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    // Function to start Picture-in-Picture mode
    private fun startPictureInPictureMode() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val aspectRatio = Rational(16, 9)  // Adjust aspect ratio
            val pipParams = android.app.PictureInPictureParams.Builder()
                .setAspectRatio(aspectRatio)
                .build()
            enterPictureInPictureMode(pipParams)  // Start PiP mode
        } else {
            Toast.makeText(this, "PiP not supported on this device", Toast.LENGTH_SHORT).show()
        }
    }

    // Function to adjust the screen brightness
    private fun setScreenBrightness(brightness: Float) {
        val resolver: ContentResolver = contentResolver
        try {
            // Ensure brightness stays within 0-1 range and convert to 0-255 scale
            val brightnessValue = (brightness * 255).toInt().coerceIn(0, 255)
            Settings.System.putInt(resolver, Settings.System.SCREEN_BRIGHTNESS, brightnessValue)
        } catch (e: SecurityException) {
            e.printStackTrace()
            Toast.makeText(this, "Permission denied to change brightness", Toast.LENGTH_SHORT).show()
        }
    }

    // Function to adjust the system volume
    private fun setSystemVolume(volume: Int) {
        val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
        val maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
        val volumeLevel = (volume * maxVolume) / 100  // Convert volume percentage to the range of max volume
        audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, volumeLevel, 0)
    }

    // Function to check and request WRITE_SETTINGS permission (required for brightness control)
    private fun checkAndRequestWriteSettingsPermission() {
        if (!Settings.System.canWrite(this)) {
            val intent = Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS)
            startActivityForResult(intent, 200)
        }
    }

    // Handle the result of the WRITE_SETTINGS permission request
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 200) {
            if (Settings.System.canWrite(this)) {
                // Permission granted, proceed with changing brightness
                Toast.makeText(this, "Permission granted to change brightness", Toast.LENGTH_SHORT).show()
            } else {
                // Permission denied, inform the user
                Toast.makeText(this, "Permission denied to change brightness", Toast.LENGTH_SHORT).show()
            }
        }
    }

    // Optionally, you can request permission at the time the activity is created
    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        super.onCreate(savedInstanceState)
        checkAndRequestWriteSettingsPermission()  // Check if the app can change screen brightness
    }
}
