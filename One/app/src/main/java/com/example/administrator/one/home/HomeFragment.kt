package com.example.administrator.one.home

import android.view.View
import com.example.administrator.one.BaseFragment
import com.example.administrator.one.R
import com.example.administrator.one.util.GlideImageLoader
import kotlinx.android.synthetic.main.fragment_home.view.*

class HomeFragment : BaseFragment() {

    override fun initView(rootView: View) {
        rootView.banner.setImages(mutableListOf<String>()).setImageLoader(GlideImageLoader())
    }

    override fun initData() {

    }

    override fun getLayoutId(): Int {
        return R.layout.fragment_home
    }

    override fun onStart() {
        super.onStart()
        view?.banner?.startAutoPlay()
    }

    override fun onStop() {
        super.onStop()
        view?.banner?.stopAutoPlay()
    }
}