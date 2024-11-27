package com.example.ogo

import android.os.Build
import android.app.PictureInPictureParams
import android.util.Rational
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "pip_channel")
            .setMethodCallHandler { call, result ->
                if (call.method == "enterPiP") {
                    startPictureInPictureMode() // Call the renamed method
                    result.success(null)
                } else {
                    result.notImplemented()
                }
            }
    }

    fun startPictureInPictureMode() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val aspectRatio = Rational(16, 9) // Adjust aspect ratio
            val pipParams = PictureInPictureParams.Builder()
                .setAspectRatio(aspectRatio)
                .build()
            enterPictureInPictureMode(pipParams) // Call the built-in method
        }
    }
}
