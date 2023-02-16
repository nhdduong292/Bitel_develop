package com.bitel.bss.viettelpos.v3.bitel_ventas

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Bundle
import android.os.Handler
import android.os.Looper

class MainActivity: FlutterActivity() {
    private val CHANNEL = "bitel.com/demo"
    private val EVENT_CHANNEL = "bitel.com/demoevent"
    private lateinit var channel: MethodChannel
    private lateinit var eventChannel: EventChannel
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
//            // This method is invoked on the main thread.
//                call, result ->
//            if (call.method == "getBatteryLevel") {
//                val batteryLevel = getBatteryLevel()
//
//                if (batteryLevel != -1) {
//                    var arguments = call.arguments() as Map<String,String>?
////                    var name = arguments["name"]
//                    var name = arguments?.get("name")?.toString() ?: "1766400"
//
//                    result.success("$name To: $batteryLevel %")
//                } else {
//                    result.error("UNAVAILABLE", "Battery level not available.", null)
//                }
//            } else {
//                result.notImplemented()
//            }
//        }
    }
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        Log.d("RecirdingActivity", "InitializeMap") //called
//        Handler(Looper.getMainLooper()).postDelayed(Runnable{
//            val batteryLevel = getBatteryLevel()
//            channel.invokeMethod("reportBa", batteryLevel)
//        }, 100)

        Handler(Looper.getMainLooper()).postDelayed({
            val batteryLevel = getBatteryLevel()
            channel.invokeMethod("reportBa", batteryLevel)
        }, 0)
    }
    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }
}
