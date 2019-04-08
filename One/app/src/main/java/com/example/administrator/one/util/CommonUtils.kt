package com.example.administrator.one.util

import java.text.SimpleDateFormat
import java.util.*

object CommonUtils {

    fun formatTime(normalDateString: String?, pattern: String = "EEE dd MM. yyyy"): String {
        val simpleDateFormat = SimpleDateFormat(pattern, Locale.CHINA)
        val date = SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.CHINA).parse(normalDateString)
        return simpleDateFormat.format(date)
    }

}