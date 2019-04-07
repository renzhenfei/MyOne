package com.example.administrator.one

import android.app.Application
import android.content.Context
import com.hjq.toast.ToastUtils

class App : Application() {

    companion object {
        var application:Context? = null
    }

    override fun onCreate() {
        super.onCreate()
        application = applicationContext
        ToastUtils.init(this)
    }

}