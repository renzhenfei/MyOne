package com.example.administrator.one.music

import android.animation.Animator
import android.animation.ValueAnimator
import android.graphics.Color
import android.support.v4.view.ViewPager
import android.util.Log
import android.view.View
import com.example.administrator.one.BaseFragment
import com.example.administrator.one.R
import com.example.administrator.one.adapter.BaseFragmentPageAdapter
import com.example.administrator.one.common.api.API
import com.example.administrator.one.common.api.ApiUrl
import com.example.administrator.one.common.api.BaseObserver
import com.trello.rxlifecycle2.android.FragmentEvent
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import kotlinx.android.synthetic.main.fragment_music.view.*
import me.dkzwm.widget.srl.HorizontalSmoothRefreshLayout
import me.dkzwm.widget.srl.RefreshingListenerAdapter
import me.dkzwm.widget.srl.SmoothRefreshLayout
import me.dkzwm.widget.srl.extra.footer.MaterialFooter
import me.dkzwm.widget.srl.extra.header.MaterialHeader
import me.dkzwm.widget.srl.indicator.DefaultIndicator

class MusicFragment : BaseFragment(), ViewPager.OnPageChangeListener {

    private var refreshLayout: HorizontalSmoothRefreshLayout? = null
    private val musicIds = mutableListOf<String>()
    private var adapter:BaseFragmentPageAdapter? = null

    companion object {
        val TAG = this::class.java.name
        fun newInstance(): MusicFragment {
            return MusicFragment()
        }
    }

    override fun initView(rootView: View) {
        adapter = BaseFragmentPageAdapter(childFragmentManager,musicIds)
        rootView.vp0.adapter = adapter
        rootView.vp0.addOnPageChangeListener(this)
        refreshLayout = rootView.refreshView
        val header = MaterialHeader<DefaultIndicator>(activity)
        header.setColorSchemeColors(intArrayOf(Color.RED, Color.BLUE, Color.GREEN, Color.BLACK))
        refreshLayout?.setHeaderView(header)
        val footer = MaterialFooter<DefaultIndicator>(activity)
        footer.setProgressBarColors(intArrayOf(Color.RED, Color.BLUE, Color.GREEN, Color.BLACK))
        refreshLayout?.setFooterView(footer)
        refreshLayout?.setDisableLoadMore(true)
        refreshLayout?.setDisableRefresh(true)
        refreshLayout?.setDisablePerformLoadMore(false)
        refreshLayout?.setEnableKeepRefreshView(true)
        refreshLayout?.setDisableWhenAnotherDirectionMove(true)
        refreshLayout?.setOnRefreshListener(object : RefreshingListenerAdapter() {
            override fun onRefreshing() {
                initData()
            }

            override fun onLoadingMore() {
                initData()
            }
        })
        refreshLayout?.setOnLoadMoreScrollCallback { _, delta -> Log.e("setOnLoadMore = ",delta.toString()) }
        refreshLayout?.setRatioToKeep(1F)
        refreshLayout?.setRatioToRefresh(1F)
        refreshLayout?.autoRefresh(false)
    }

    override fun initData() {
        API.retrofit?.create(ApiUrl::class.java)
                ?.getMusicIdList()
                //绑定线程
                ?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
                //绑定生命周期
                ?.compose(bindUntilEvent(FragmentEvent.DESTROY))
                ?.subscribe(object : BaseObserver<MutableList<String>>() {
                    override fun onFailure(code: Int?) {
                    }

                    override fun onSuccess(data: MutableList<String>?) {
                        if (data?.isNotEmpty()!!){
                            musicIds.clear()
                            musicIds.addAll(data)
                            adapter?.notifyDataSetChanged()
                            refreshComplete()
                        }
                    }
                })
    }

    private fun refreshComplete() {
        val valueAnim = ValueAnimator.ofInt(0,100)
        valueAnim.duration = 2000
        valueAnim.addUpdateListener {
            val value = it.animatedValue as Int
//            refreshLayout?.headerView.
        }
        valueAnim.addListener(object : Animator.AnimatorListener {
            override fun onAnimationRepeat(animation: Animator?) {

            }

            override fun onAnimationEnd(animation: Animator?) {
                refreshLayout?.refreshComplete()
            }

            override fun onAnimationCancel(animation: Animator?) {

            }

            override fun onAnimationStart(animation: Animator?) {

            }
        })
    }

    override fun getLayoutId(): Int {
        return R.layout.fragment_music
    }

    override fun onPageScrollStateChanged(p0: Int) {

    }

    override fun onPageScrolled(p0: Int, p1: Float, p2: Int) {
        when (p0) {
            0 -> {
                refreshLayout?.setDisableLoadMore(true)
                refreshLayout?.setDisableRefresh(p2 > 0)
            }
            musicIds.size - 1 -> {
                refreshLayout?.setDisableLoadMore(p2 > 0)
                refreshLayout?.setDisableRefresh(true)
            }
            else -> {
                refreshLayout?.setDisableLoadMore(true)
                refreshLayout?.setDisableRefresh(true)
            }
        }
    }

    override fun onPageSelected(p0: Int) {

    }

}