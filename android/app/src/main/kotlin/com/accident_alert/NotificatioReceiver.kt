package com.AcciSense

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.google.firebase.firestore.FirebaseFirestore

class NotificationReceiver : BroadcastReceiver()
 {
    val action = intent.action
    val docId = intent.getStringExtra("docId") ?: return

    val db = FirebaseFirestore.getInstance()
 }