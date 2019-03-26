package com.example.administrator.one.read

import android.view.View
import com.example.administrator.one.BaseFragment
import com.example.administrator.one.R

class ReadFragment : BaseFragment() {

    companion object {
        val TAG = this::class.java.name
        fun newInstance():ReadFragment{
            return ReadFragment()
        }
    }

    override fun initView(rootView: View) {

    }

    override fun initData() {

    }

    override fun getLayoutId(): Int {
        return R.layout.fragment_read
    }
}