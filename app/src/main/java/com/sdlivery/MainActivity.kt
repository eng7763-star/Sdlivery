package com.sdlivery

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import com.sdlivery.drivers.DriverScreen
import com.sdlivery.schools.SchoolScreen
import com.sdlivery.students.StudentScreen

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        findViewById<Button>(R.id.btn_driver).setOnClickListener {
            startActivity(Intent(this, DriverScreen::class.java))
        }
        findViewById<Button>(R.id.btn_school).setOnClickListener {
            startActivity(Intent(this, SchoolScreen::class.java))
        }
        findViewById<Button>(R.id.btn_student).setOnClickListener {
            startActivity(Intent(this, StudentScreen::class.java))
        }
    }
}