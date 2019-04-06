package com.example.administrator.one.adapter

import android.support.v4.view.PagerAdapter
import android.util.SparseArray
import android.view.View
import android.view.ViewGroup

abstract class BasePageAdapter<T>(private val data: MutableList<T>) : PagerAdapter() {

    private val views: SparseArray<View> = SparseArray(data.size)
    override fun isViewFromObject(p0: View, p1: Any): Boolean {
        return p0 == p1
    }

    override fun getCount(): Int {
        return data.size
    }

    override fun instantiateItem(container: ViewGroup, position: Int): Any {
        var view = views[position]
        if (view == null){
            view = newView(data[position],container)
            views.put(position,view)
        }
        container.addView(view)
        return view
    }

    abstract fun newView(t: T, container: ViewGroup): View?

    override fun destroyItem(container: ViewGroup, position: Int, `object`: Any) {
        container.removeView(views[position])
    }
}