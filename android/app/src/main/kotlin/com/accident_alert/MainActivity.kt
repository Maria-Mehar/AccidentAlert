package com.accident_alert

import io.flutter.embedding.android.FlutterActivity
import android.app.PendingIntent

class MainActivity : FlutterActivity()
{

    

override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    createNotificationChannel()


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

private fun createNotificationChannel() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        val channel = NotificationChannel(
            "accident_channel", // Channel ID
            "Accident Alerts",  // Name
            NotificationManager.IMPORTANCE_HIGH
        )
        val manager = getSystemService(NotificationManager::class.java)
        manager.createNotificationChannel(channel)
    }
}

private fun showAccidentNotification(docId: String) {
val confirmIntent = Intent(this, NotificationReceiver::class.java).apply {
    action = "CONFIRM_ACTION"
    putExtra("docId", docId)
}

val confirmPendingIntent = PendingIntent.getBroadcast(
    this, 0, confirmIntent, 
    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
)

val cancelIntent = Intent(this, NotificationReceiver::class.java).apply {
            action = "CANCEL_ACTION"
            putExtra("docId", docId)
        }

        val cancelPendingIntent = PendingIntent.getBroadcast(
            this,
            1,
            cancelIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )



val builder = NotificationCompat.Builder(this, "accident_channel")
    .setSmallIcon(R.mipmap.ic_launcher)
    .setContentTitle("Accident Alert")
    .setContentText("Accident detected! Are you okay?")
    .setPriority(NotificationCompat.PRIORITY_HIGH)
    .addAction(0, "Confirm", confirmPendingIntent) // Button 1
    .addAction(0, "Cancel", cancelPendingIntent)   // Button 2

val manager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
manager.notify(101, builder.build())
}
}