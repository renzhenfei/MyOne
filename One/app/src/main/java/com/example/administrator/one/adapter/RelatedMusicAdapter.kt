package com.example.administrator.one.adapter

import android.view.View
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.BaseViewHolder
import com.example.administrator.one.R
import com.example.administrator.one.model.MusicRelatedModel
import com.example.administrator.one.util.ImageLoaderUtil
import kotlinx.android.synthetic.main.cell_music_related.view.*

class RelatedMusicAdapter(data:MutableList<MusicRelatedModel>) : BaseQuickAdapter<MusicRelatedModel, RelatedMusicAdapter.VH>(R.layout.cell_music_related,data) {

    override fun convert(helper: VH?, item: MusicRelatedModel?) {
        helper?.configureModel(item)
    }


    inner class VH(private val view :View) :BaseViewHolder(view){
        fun configureModel(model : MusicRelatedModel?){
            if (model == null){
                return
            }
            ImageLoaderUtil.displayRoundImage(view.context,model.cover,view.coverView)
            view.musicNameLabel.text = model.title
            view.authorNameLabel.text = model.author.userName
        }
    }
}

