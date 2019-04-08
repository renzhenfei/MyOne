package com.example.administrator.one.adapter

import android.support.v4.app.Fragment
import android.support.v4.app.FragmentManager
import android.support.v4.app.FragmentStatePagerAdapter
import com.example.administrator.one.music.MusicDetailFragment

class BaseFragmentPageAdapter(fm: FragmentManager, private val musicIds: MutableList<String>) : FragmentStatePagerAdapter(fm) {

    override fun getItem(p0: Int): Fragment {
        return MusicDetailFragment.newInstance(musicIds[p0])
    }

    override fun getCount(): Int {
        return musicIds.size
    }
}