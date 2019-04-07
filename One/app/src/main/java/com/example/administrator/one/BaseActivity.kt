package com.example.administrator.one

import android.os.Bundle
import com.gyf.barlibrary.BarHide
import com.gyf.barlibrary.ImmersionBar
import com.tbruyelle.rxpermissions2.RxPermissions
import com.trello.rxlifecycle2.components.support.RxAppCompatActivity

abstract class BaseActivity : RxAppCompatActivity() {

    private var rxPermissions: RxPermissions? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(getLayoutId())
        val immersionBar = ImmersionBar.with(this).statusBarDarkFont(true)
        if (hideStatusBar()) {
            immersionBar.hideBar(BarHide.FLAG_HIDE_BAR)
        }
        immersionBar.init()
        if (hideActionBar()) {
            supportActionBar?.hide()
        }
        initView()
        initData()
    }

    open fun hideActionBar(): Boolean {
        return true
    }

    open fun hideStatusBar(): Boolean {
        return false
    }

    abstract fun getLayoutId(): Int

    abstract fun initData()

    abstract fun initView()

    protected fun showProgress() {

    }

    protected fun hideProgress() {

    }

    /**
     * 请求多个权限挨个返回结果
     */
    protected fun requestPermissions(vararg permissions: String) {
        if (rxPermissions == null) {
            rxPermissions = RxPermissions(this)
        }
        rxPermissions
                ?.requestEachCombined(*permissions)
                ?.subscribe {
                    when {
                        it.granted -> permissionRequestResult(true)
                        it.shouldShowRequestPermissionRationale -> {//不再提示 引导用户自己打开该权限

                        }
                        else -> {
                            permissionRequestResult(false)
                        }
                    }
                }
    }

    /**
     * 请求一个或多个权限返回一个结果
     */
    protected fun requestPermission(vararg permission: String) {
        if (rxPermissions == null) {
            rxPermissions = RxPermissions(this)
        }
        rxPermissions
                ?.request(*permission)
                ?.subscribe {
                    permissionRequestResult(it)
                }
    }

    protected fun permissionRequestResult(granted: Boolean) {}


}