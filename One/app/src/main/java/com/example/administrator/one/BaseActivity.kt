package com.example.administrator.one

import android.os.Bundle
import com.gyf.barlibrary.ImmersionBar
import com.trello.rxlifecycle2.components.support.RxAppCompatActivity

abstract class BaseActivity : RxAppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(getLayoutId())
        ImmersionBar.with(this).statusBarDarkFont(true).init()
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