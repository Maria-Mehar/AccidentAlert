package com.accident_alert

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity()

override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)


    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "accident_channel")
        .setMethodCallHandler { call, result ->
            if (call.method == "showNotification") {
                val docId = call.argument<String>("docId")
                if (docId != null) {
                    showAccidentNotification(docId) 
                    result.success("Native Notification Triggered")
                } else {
                    result.error("ERROR", "docId missing", null)
                }
            } else {
                result.notImplemented()
            }
        }
}