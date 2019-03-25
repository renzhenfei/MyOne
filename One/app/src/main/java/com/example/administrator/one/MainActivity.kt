package com.example.administrator.one

import android.os.Build
import android.support.v7.app.ActionBar
import android.support.design.widget.BottomNavigationView
import android.view.View
import com.example.administrator.one.common.api.API
import com.example.administrator.one.common.api.ApiUrl
import com.example.administrator.one.common.api.BaseObserver
import com.example.administrator.one.util.SelectorUtil
import com.trello.rxlifecycle2.android.ActivityEvent
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : BaseActivity() {

    private val mOnNavigationItemSelectedListener = BottomNavigationView.OnNavigationItemSelectedListener { item ->
        when (item.itemId) {
            R.id.navigation_home -> {
                message.setText(R.string.title_home)
                return@OnNavigationItemSelectedListener true
            }
            R.id.navigation_read -> {
                message.setText(R.string.title_read)
                return@OnNavigationItemSelectedListener true
            }
            R.id.navigation_music -> {
                message.setText(R.string.title_music)
                return@OnNavigationItemSelectedListener true
            }
            R.id.navigation_movie -> {
                message.setText(R.string.title_movie)
                return@OnNavigationItemSelectedListener true
            }
        }
        false
    }

    override fun getLayoutId(): Int {
        return R.layout.activity_main
    }

    override fun initData() {
        API.retrofit?.create(ApiUrl::class.java)
                ?.getRetrofit()
                //绑定线程
                ?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
                //绑定生命周期
                ?.compose(bindUntilEvent(ActivityEvent.DESTROY))
                ?.subscribe(object : BaseObserver<Any>() {
                    override fun onFailure(code: Int?) {

                    }

                    override fun onSuccess(data: Any?) {

                    }

                })
    }

    override fun initView() {
        val actionBarView = View.inflate(this, R.layout.action_bar_content_view, null)
        val layoutP : ActionBar.LayoutParams = ActionBar.LayoutParams(ActionBar.LayoutParams.MATCH_PARENT,ActionBar.LayoutParams.MATCH_PARENT)
        supportActionBar?.setCustomView(actionBarView,layoutP)
        supportActionBar?.displayOptions = ActionBar.DISPLAY_SHOW_CUSTOM
        supportActionBar?.setDisplayShowCustomEnabled(true)
        if(Build.VERSION.SDK_INT>=21){
            supportActionBar?.elevation = 0f
        }
        val colorStateList = SelectorUtil.generateColorStateList(this, R.color.text_color_normal, R.color.text_color_checked)
        navigation.itemTextColor = colorStateList
        navigation.itemIconTintList = colorStateList
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener)
    }

}
