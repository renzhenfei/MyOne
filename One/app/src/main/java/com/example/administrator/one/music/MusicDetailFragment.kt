package com.example.administrator.one.music

import android.os.Bundle
import android.support.v7.widget.LinearLayoutManager
import android.view.View
import com.example.administrator.one.BaseFragment
import com.example.administrator.one.R
import com.example.administrator.one.adapter.MusicPageDetailAdapter
import com.example.administrator.one.model.DetailType
import com.example.administrator.one.util.DefaultItemDecoration
import kotlinx.android.synthetic.main.fragment_music_detail.*

class MusicDetailFragment : BaseFragment() {

    private val data:MutableList<DetailType> = mutableListOf()
    private val adapter:MusicPageDetailAdapter = MusicPageDetailAdapter(data)

    companion object {

        private const val MUSIC_ID = "music_id"

        @JvmStatic
        fun newInstance(musicId:String):MusicDetailFragment{
            val b = Bundle()
            b.putString(MUSIC_ID,musicId)
            val fragment  = MusicDetailFragment()
            fragment.arguments = b
            return fragment
        }
    }

    override fun getLayoutId(): Int {
        return R.layout.fragment_music_detail
    }

    override fun initView(rootView: View) {
        list.adapter = adapter
        list.layoutManager = LinearLayoutManager(activity,LinearLayoutManager.VERTICAL,false)
        list.addItemDecoration(DefaultItemDecoration(activity!!))
    }

    override fun initData() {
        val musicId = arguments?.getString(MUSIC_ID)

    }
}