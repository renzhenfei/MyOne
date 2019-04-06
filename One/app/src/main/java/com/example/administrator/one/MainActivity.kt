package com.example.administrator.one

import android.os.Build
import android.support.design.internal.BaselineLayout
import android.support.design.internal.BottomNavigationMenuView
import android.support.design.widget.BottomNavigationView
import android.support.v7.app.ActionBar
import android.util.TypedValue
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import com.example.administrator.one.common.api.API
import com.example.administrator.one.common.api.ApiUrl
import com.example.administrator.one.common.api.BaseObserver
import com.example.administrator.one.home.HomeFragment
import com.example.administrator.one.movie.MovieFragment
import com.example.administrator.one.music.MusicFragment
import com.example.administrator.one.read.ReadFragment
import com.example.administrator.one.util.SelectorUtil
import com.trello.rxlifecycle2.android.ActivityEvent
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import kotlinx.android.synthetic.main.activity_main.*

enum class PageType {
    HOME, READ, MUSIC, MOVIE
}

class MainActivity : BaseActivity() {

    private var mCurrentFragment: BaseFragment? = null

    private val mOnNavigationItemSelectedListener = BottomNavigationView.OnNavigationItemSelectedListener { item ->
        when (item.itemId) {
            R.id.navigation_home -> {
                switchFragment(PageType.HOME)
                return@OnNavigationItemSelectedListener true
            }
            R.id.navigation_read -> {
                switchFragment(PageType.READ)
                return@OnNavigationItemSelectedListener true
            }
            R.id.navigation_music -> {
                switchFragment(PageType.MUSIC)
                return@OnNavigationItemSelectedListener true
            }
            R.id.navigation_movie -> {
                switchFragment(PageType.MOVIE)
                return@OnNavigationItemSelectedListener true
            }
        }
        false
    }

    private fun switchFragment(type: PageType) {
        val transaction = supportFragmentManager.beginTransaction()
        val newTag: String = when (type) {
            PageType.HOME -> HomeFragment.TAG
            PageType.READ -> ReadFragment.TAG
            PageType.MUSIC -> MusicFragment.TAG
            PageType.MOVIE -> MovieFragment.TAG
        }
        var newFragment = supportFragmentManager.findFragmentByTag(newTag)

        if (mCurrentFragment != null) {
            if (mCurrentFragment!! == newFragment) {
                //点击的同一个 可进行刷新页面处理
            } else {
                transaction.hide(mCurrentFragment!!)
                if (newFragment == null) {
                    newFragment = newFragment(type)
                    transaction.add(newFragment, newTag)
                } else {
                    transaction.show(newFragment)
                }
            }
        } else {
            //第一次进来 newFragment也应该是null
            newFragment = newFragment(type)
            transaction.add(newFragment, newTag)
        }
        transaction.commit()
        mCurrentFragment = newFragment as BaseFragment
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
        val layoutP: ActionBar.LayoutParams = ActionBar.LayoutParams(ActionBar.LayoutParams.MATCH_PARENT, ActionBar.LayoutParams.MATCH_PARENT)
        supportActionBar?.setCustomView(actionBarView, layoutP)
        supportActionBar?.displayOptions = ActionBar.DISPLAY_SHOW_CUSTOM
        supportActionBar?.setDisplayShowCustomEnabled(true)
        if (Build.VERSION.SDK_INT >= 21) {
            supportActionBar?.elevation = 0f
        }
        val colorStateList = SelectorUtil.generateColorStateList(this, R.color.text_color_checked, R.color.text_color_normal)
        navigation.itemTextColor = colorStateList
        navigation.itemIconTintList = null
        val menuView: BottomNavigationMenuView = navigation.getChildAt(0) as BottomNavigationMenuView
        for (i in 0..menuView.childCount) {
            val childAt = menuView.getChildAt(i)
            if (childAt is ViewGroup) {
                for (j in 0..childAt.childCount) {
                    val view = childAt.getChildAt(j)
                    if (view is ImageView) {
                        view.setPadding(0, -14, 0, 0)
                        val layoutParams = view.layoutParams
                        val displayMetrics = resources.displayMetrics
                        layoutParams.height = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, 40f, displayMetrics).toInt()
                        layoutParams.width = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, 40f, displayMetrics).toInt()
                        view.layoutParams = layoutParams
                    }
                    if (view is BaselineLayout) {
                        view.setPadding(0, 0, 0, 0)
                    }
                }
            }
        }
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener)
    }

    private fun newFragment(pageType: PageType): BaseFragment {
        return when (pageType) {
            PageType.HOME -> HomeFragment.newInstance()
            PageType.READ -> ReadFragment.newInstance()
            PageType.MUSIC -> MusicFragment.newInstance()
            PageType.MOVIE -> MovieFragment.newInstance()
        }
    }

}
