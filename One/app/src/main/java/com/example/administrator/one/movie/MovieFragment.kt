package com.example.administrator.one.movie

import android.view.View
import com.example.administrator.one.BaseFragment
import com.example.administrator.one.R

class MovieFragment : BaseFragment() {

    companion object {
        val TAG = this::class.java.name
        fun newInstance(): MovieFragment {
            return MovieFragment()
        }
    }

    override fun initView(rootView: View) {

    }

    override fun initData() {

    }

    override fun getLayoutId(): Int {
        return R.layout.fragment_movie
    }
}