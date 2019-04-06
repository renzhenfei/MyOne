package com.example.administrator.one

import android.os.Bundle
import android.support.annotation.LayoutRes
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.tbruyelle.rxpermissions2.RxPermissions
import com.trello.rxlifecycle2.components.support.RxFragment

abstract class BaseFragment : RxFragment() {
    private var rxPermissions: RxPermissions? = null

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val rootView = LayoutInflater.from(context).inflate(getLayoutId(), container, false)
        initView(rootView)
        initData()
        return rootView
    }


    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        retainInstance = true

    }

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
                ?.subscribe({
                    when {
                        it.granted -> permissionRequestResult(true)
                        it.shouldShowRequestPermissionRationale -> {//不再提示 引导用户自己打开该权限

                        }
                        else -> {
                            permissionRequestResult(false)
                        }
                    }
                })
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

    fun getTAG(): String {
        return BaseFragment::class.java.name
    }

    @LayoutRes
    abstract fun getLayoutId(): Int

    abstract fun initView(rootView: View)

    abstract fun initData()
}
