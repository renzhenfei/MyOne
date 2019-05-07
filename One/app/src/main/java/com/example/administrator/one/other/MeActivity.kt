package com.example.administrator.one.other

import android.support.v7.widget.LinearLayoutManager
import com.example.administrator.one.BaseActivity
import com.example.administrator.one.R
import com.example.administrator.one.adapter.MeAdapter
import kotlinx.android.synthetic.main.activity_me.*

class MeActivity : BaseActivity() {

    override fun getLayoutId(): Int {
        return R.layout.activity_me
    }

    override fun initData() {
        val adapter = MeAdapter(mutableListOf("a","d","g","d","a","d","g","d","a","d","g","d"))
        recyclerView.layoutManager = LinearLayoutManager(this,LinearLayoutManager.HORIZONTAL,false)
        recyclerView.adapter = adapter
    }

    override fun initView() {
    }
}