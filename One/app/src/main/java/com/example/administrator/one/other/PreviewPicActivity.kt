package com.example.administrator.one.other

import android.support.v4.view.ViewCompat
import android.transition.Transition
import com.example.administrator.one.BaseActivity
import com.example.administrator.one.R
import com.example.administrator.one.util.ImageLoaderUtil
import kotlinx.android.synthetic.main.activity_preview_pic.*

class PreviewPicActivity : BaseActivity() {

    companion object {
        const val PICTURE_URL = "picture_url"
    }

    override fun getLayoutId(): Int {
        return R.layout.activity_preview_pic
    }

    override fun initData() {
    }

    override fun initView() {
        val picUrl = intent.getStringExtra(PICTURE_URL)
        ViewCompat.setTransitionName(pic, picUrl)
        ImageLoaderUtil.displayThumbnailImage(this, picUrl, pic)
        addTransitionListener()
        pic.setOnPhotoTapListener { _, _, _ ->
            onBackPressed()
        }
    }

    private fun addTransitionListener() {
        val transition = window.sharedElementEnterTransition
        transition?.addListener(object : Transition.TransitionListener {
            override fun onTransitionEnd(transition: Transition?) {
                ImageLoaderUtil.displayImage(this@PreviewPicActivity, ViewCompat.getTransitionName(pic)!!, pic)
                transition?.removeListener(this)
            }

            override fun onTransitionResume(transition: Transition?) {

            }

            override fun onTransitionPause(transition: Transition?) {

            }

            override fun onTransitionCancel(transition: Transition?) {
                transition?.removeListener(this)
            }

            override fun onTransitionStart(transition: Transition?) {

            }

        })
    }

    override fun hideStatusBar(): Boolean {
        return true
    }
}