package com.example.administrator.one.music

import android.view.View
import com.example.administrator.one.BaseFragment
import com.example.administrator.one.R

class MusicFragment : BaseFragment() {

    companion object {
        val TAG = this::class.java.name
        fun newInstance(): MusicFragment {
            return MusicFragment()
        }
    }

    override fun initView(rootView: View) {

    }

    override fun initData() {

    }

    override fun getLayoutId(): Int {
        return R.layout.fragment_music
    }
}