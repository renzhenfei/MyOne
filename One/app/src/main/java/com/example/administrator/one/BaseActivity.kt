package com.example.administrator.one

import android.os.Bundle
import android.support.v7.app.AppCompatActivity

abstract class BaseActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(getLayoutId())
        initView()
        initData()
    }

    abstract fun getLayoutId(): Int

    abstract fun initData()

    abstract fun initView()

    protected fun showProgress() {

    }

    protected fun hideProgress() {

    }



}