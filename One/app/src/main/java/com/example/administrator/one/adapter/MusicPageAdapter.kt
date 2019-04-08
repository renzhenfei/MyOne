package com.example.administrator.one.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.example.administrator.one.R
import com.example.administrator.one.model.MusicPageModel
import kotlinx.android.synthetic.main.cell_music_page.view.*

class MusicPageAdapter(musicPageModels: MutableList<MusicPageModel>) : BasePageAdapter<MusicPageModel>(musicPageModels) {

    override fun newView(t: MusicPageModel, container: ViewGroup): View? {
        val rootView = LayoutInflater.from(container.context).inflate(R.layout.cell_music_page,container,false)
        rootView.list.adapter
        return rootView
    }
}