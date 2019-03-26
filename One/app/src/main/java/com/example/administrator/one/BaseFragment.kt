package com.example.administrator.one

import android.content.Context
import android.os.Bundle
import android.support.annotation.LayoutRes
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.trello.rxlifecycle2.components.support.RxFragment

abstract class BaseFragment : RxFragment() {

    override fun onAttach(context: Context?) {
        super.onAttach(context)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val rootView = LayoutInflater.from(context).inflate(getLayoutId(), container, false)
        initView(rootView)
        return rootView
    }


    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        retainInstance = true
        initData()
    }

    protected fun showProgress() {

    }

    protected fun hideProgress() {

    }

    @LayoutRes
    abstract fun getLayoutId(): Int

    abstract fun initView(rootView: View)

    abstract fun initData()

    fun getTAG(): String {
        return BaseFragment::class.java.name
    }
}
