package com.example.administrator.one

import android.os.Build
import android.support.design.internal.BaselineLayout
import android.support.design.internal.BottomNavigationMenuView
import android.support.design.widget.BottomNavigationView
import android.support.v7.app.ActionBar
import android.support.v7.widget.Toolbar
import android.util.TypedValue
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import com.example.administrator.one.home.HomeFragment
import com.example.administrator.one.movie.MovieFragment
import com.example.administrator.one.music.MusicFragment
import com.example.administrator.one.other.MeActivity
import com.example.administrator.one.read.ReadFragment
import com.example.administrator.one.util.Router
import com.example.administrator.one.util.SelectorUtil
import kotlinx.android.synthetic.main.action_bar_content_view.view.*
import kotlinx.android.synthetic.main.activity_main.*

enum class PageType {
    HOME, READ, MUSIC, MOVIE
}

class MainActivity : BaseActivity() {

    private var mCurrentFragment: BaseFragment? = null
    private var searchBtn: View? = null
    private var meBtn: View? = null
    private var title: TextView? = null
    private var titleIcon: ImageView? = null

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
            PageType.HOME -> {
                setTitleIcon()
                HomeFragment.TAG
            }
            PageType.READ -> {
                setTitle("阅读")
                ReadFragment.TAG
            }
            PageType.MUSIC -> {
                setTitle("音乐")
                MusicFragment.TAG
            }
            PageType.MOVIE -> {
                setTitle("电影")
                MovieFragment.TAG
            }
        }
        var newFragment = supportFragmentManager.findFragmentByTag(newTag)

        if (mCurrentFragment != null) {
            if (mCurrentFragment!! == newFragment) {
                //点击的同一个 可进行刷新页面处理
            } else {
                transaction.hide(mCurrentFragment!!)
                if (newFragment == null) {
                    newFragment = newFragment(type)
                    transaction.add(R.id.fragment, newFragment, newTag)
                } else {
                    transaction.show(newFragment)
                }
            }
        } else {
            if (newFragment == null) {
                newFragment = newFragment(type)
                transaction.add(R.id.fragment, newFragment, newTag)
            } else {
                transaction.show(newFragment)
            }
        }
        transaction.commit()
        mCurrentFragment = newFragment as BaseFragment
    }

    override fun getLayoutId(): Int {
        return R.layout.activity_main
    }

    override fun initData() {
        switchFragment(PageType.HOME)
    }

    override fun initView() {
        val actionBarView = View.inflate(this, R.layout.action_bar_content_view, null)
        searchBtn = actionBarView.leftIcon
        meBtn = actionBarView.rightIcon
        title = actionBarView.title
        titleIcon = actionBarView.titleIcon
        val layoutP: ActionBar.LayoutParams = ActionBar.LayoutParams(ActionBar.LayoutParams.MATCH_PARENT, ActionBar.LayoutParams.MATCH_PARENT)
        supportActionBar?.setCustomView(actionBarView, layoutP)
        supportActionBar?.displayOptions = ActionBar.DISPLAY_SHOW_CUSTOM
        supportActionBar?.setDisplayShowCustomEnabled(true)
        val toolbar = actionBarView.parent as Toolbar
        toolbar.setContentInsetsAbsolute(0, 0)
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
        initListener()
    }

    private fun initListener() {
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener)
        searchBtn?.setOnClickListener { Router.toSearch(this) }
        meBtn?.setOnClickListener { Router.toActivity(this, MeActivity::class.java) }
    }

    private fun newFragment(pageType: PageType): BaseFragment {
        return when (pageType) {
            PageType.HOME -> HomeFragment.newInstance()
            PageType.READ -> ReadFragment.newInstance()
            PageType.MUSIC -> MusicFragment.newInstance()
            PageType.MOVIE -> MovieFragment.newInstance()
        }
    }

    override fun hideActionBar(): Boolean {
        return false
    }

    private fun setTitle(title: String) {
        this@MainActivity.title?.visibility = View.VISIBLE
        this@MainActivity.titleIcon?.visibility = View.GONE
        this@MainActivity.title?.text = title
    }

    private fun setTitleIcon() {
        this@MainActivity.title?.visibility = View.GONE
        this@MainActivity.titleIcon?.visibility = View.VISIBLE
        this@MainActivity.titleIcon?.setImageResource(R.mipmap.nav_home_title)
    }
}
