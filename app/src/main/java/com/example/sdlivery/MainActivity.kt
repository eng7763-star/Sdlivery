package com.example.sdlivery

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.widget.Button

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        findViewById<Button>(R.id.btn_driver).setOnClickListener {
            startActivity(Intent(this, DriverActivity::class.java))
        }
        findViewById<Button>(R.id.btn_school).setOnClickListener {
            startActivity(Intent(this, SchoolActivity::class.java))
        }
        findViewById<Button>(R.id.btn_student).setOnClickListener {
            startActivity(Intent(this, StudentActivity::class.java))
        }
    }
}