package com.example.administrator.one.util

import android.content.Context
import android.widget.ImageView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CircleCrop
import com.bumptech.glide.request.RequestOptions
import com.example.administrator.one.R

object ImageLoaderUtil {

    fun displayImage(context: Context,url:String,img:ImageView){
        Glide.with(context)
                .load(url)
                .placeholder(R.drawable.loading)
                .into(img)
    }

    fun displayRoundImage(context: Context,url:String,img:ImageView){
        Glide.with(context)
                .load(url)
                .apply(RequestOptions.bitmapTransform(CircleCrop()))
                .placeholder(R.drawable.loading)
                .into(img)
    }

}