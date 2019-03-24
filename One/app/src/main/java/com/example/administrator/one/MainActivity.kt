package com.example.administrator.one

import android.support.design.widget.BottomNavigationView
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

    }

    override fun initView() {
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener)
    }

}
