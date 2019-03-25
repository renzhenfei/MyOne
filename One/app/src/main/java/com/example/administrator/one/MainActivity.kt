package com.example.administrator.one

import android.support.design.widget.BottomNavigationView
import com.example.administrator.one.common.api.API
import com.example.administrator.one.common.api.ApiUrl
import com.example.administrator.one.common.api.BaseObserver
import com.trello.rxlifecycle2.android.ActivityEvent
import io.reactivex.Observable
import io.reactivex.Observer
import io.reactivex.Scheduler
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
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
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener)
    }

}
