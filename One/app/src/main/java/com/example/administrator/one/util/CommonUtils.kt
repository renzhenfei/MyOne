package com.example.administrator.one.util

import java.text.SimpleDateFormat
import java.util.*

object CommonUtils {

    fun formatTime(normalDateString: String?): String {
        val simpleDateFormat = SimpleDateFormat("EEE dd MM. yyyy", Locale.CHINA)
        val date = Date()
        return simpleDateFormat.format(date)
    }

}