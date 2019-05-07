package com.example.administrator.one.adapter

import android.view.View
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.BaseViewHolder
import com.example.administrator.one.R
import com.example.administrator.one.adapter.MeAdapter.MeVH
import kotlinx.android.synthetic.main.cell_me.view.*

class MeAdapter(data:MutableList<String>) : BaseQuickAdapter<String, MeVH>(R.layout.cell_me,data) {
    override fun convert(helper: MeVH?, item: String?) {
        helper?.setData(item)
    }

    class MeVH(itemView:View) : BaseViewHolder(itemView) {
        fun setData(item: String?) {
            itemView.item.text = item
        }

    }
}

