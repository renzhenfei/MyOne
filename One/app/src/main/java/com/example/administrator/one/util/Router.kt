package com.example.administrator.one.util

import android.content.Context
import android.content.Intent
import com.example.administrator.one.BaseActivity
import com.example.administrator.one.other.PreviewPicActivity
import com.example.administrator.one.other.SearchActivity

object Router {

    fun toSearch(context: Context){
        val intent = Intent(context,SearchActivity::class.java)
        context.startActivity(intent)
    }

    fun <T : BaseActivity> toActivity(context: Context,clazz: Class<T>){
        val intent = Intent(context,clazz)
        context.startActivity(intent)
    }

    fun toPreviewImgAct(context: Context, url: String) {
        val intent = Intent(context,PreviewPicActivity::class.java)
        intent.putExtra(PreviewPicActivity.PICTURE_URL,url)
        context.startActivity(intent)
    }

}