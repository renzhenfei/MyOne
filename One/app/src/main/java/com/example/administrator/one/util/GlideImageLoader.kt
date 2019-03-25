package com.example.administrator.one.util

import android.content.Context
import android.widget.ImageView
import com.bumptech.glide.Glide
import com.youth.banner.loader.ImageLoader


class GlideImageLoader : ImageLoader() {

    override fun displayImage(context: Context?, any: Any?, imageView: ImageView?) {
        if (context == null || imageView == null){
            return
        }
        Glide.with(context)
                .load(any)
                .into(imageView)

    }
}