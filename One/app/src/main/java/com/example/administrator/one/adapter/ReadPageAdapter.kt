package com.example.administrator.one.adapter

import android.support.v7.widget.LinearLayoutManager
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.example.administrator.one.R
import com.example.administrator.one.util.DefaultItemDecoration
import kotlinx.android.synthetic.main.cell_read.view.*

class ReadPageAdapter(val data: MutableList<MutableList<Any>>) : BasePageAdapter<MutableList<Any>>(data) {

    override fun newView(t: MutableList<Any>, container: ViewGroup): View? {
        val rootView = LayoutInflater.from(container.context).inflate(R.layout.cell_read, container, false)
        rootView.list.layoutManager = LinearLayoutManager(container.context, LinearLayoutManager.VERTICAL, false)
        rootView.list.addItemDecoration(DefaultItemDecoration(container.context))
        rootView.list.adapter = ReadPageListAdapter(t)
        return rootView
    }
}