package com.example.administrator.one.home

import android.graphics.Color
import android.support.v4.view.ViewPager
import android.util.Log
import android.view.View
import com.example.administrator.one.BaseFragment
import com.example.administrator.one.adapter.HomePagerAdapter
import com.example.administrator.one.common.api.API
import com.example.administrator.one.common.api.ApiUrl
import com.example.administrator.one.common.api.BaseObserver
import com.example.administrator.one.model.HomePageModel
import com.trello.rxlifecycle2.android.FragmentEvent
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import kotlinx.android.synthetic.main.fragment_home.view.*
import me.dkzwm.widget.srl.HorizontalSmoothRefreshLayout
import me.dkzwm.widget.srl.RefreshingListenerAdapter
import me.dkzwm.widget.srl.extra.footer.MaterialFooter
import me.dkzwm.widget.srl.extra.header.MaterialHeader
import me.dkzwm.widget.srl.indicator.DefaultIndicator


class HomeFragment : BaseFragment(), ViewPager.OnPageChangeListener {

    private var refreshLayout: HorizontalSmoothRefreshLayout? = null
    private val data = mutableListOf<HomePageModel>()
    private val adapter = HomePagerAdapter(data)
    private var vp:ViewPager? = null

    companion object {
        val TAG = this::class.java.name
        fun newInstance(): HomeFragment {
            return HomeFragment()
        }
    }

    override fun initView(rootView: View) {
        vp = rootView.vp
        vp?.adapter = adapter
        vp?.addOnPageChangeListener(this)
        refreshLayout = rootView.refresh
        val header = MaterialHeader<DefaultIndicator>(activity)
        header.setColorSchemeColors(intArrayOf(Color.RED, Color.BLUE, Color.GREEN, Color.BLACK))
        refreshLayout?.setHeaderView(header)
        val footer = MaterialFooter<DefaultIndicator>(activity)
        footer.setProgressBarColors(intArrayOf(Color.RED, Color.BLUE, Color.GREEN, Color.BLACK))
        refreshLayout?.setFooterView(footer)
        refreshLayout?.setDisableLoadMore(false)
        refreshLayout?.setDisablePerformLoadMore(false)
        refreshLayout?.setEnableKeepRefreshView(true)
        refreshLayout?.setDisableWhenAnotherDirectionMove(true)
        refreshLayout?.setOnRefreshListener(object : RefreshingListenerAdapter() {
            override fun onRefreshing() {
                initData()
            }

            override fun onLoadingMore() {
                super.onLoadingMore()
            }

        })
        refreshLayout?.setRatioToKeep(1F)
        refreshLayout?.setRatioToRefresh(1F)
        refreshLayout?.autoRefresh(false)
    }

    override fun initData() {
        API.retrofit?.create(ApiUrl::class.java)
                ?.getRetrofit()
                //绑定线程
                ?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
                //绑定生命周期
                ?.compose(bindUntilEvent(FragmentEvent.DESTROY))
                ?.subscribe(object : BaseObserver<MutableList<HomePageModel>>() {
                    override fun onFailure(code: Int?) {
                        refreshLayout?.refreshComplete()
                    }

                    override fun onSuccess(data: MutableList<HomePageModel>?) {
                        this@HomeFragment.data.clear()
                        data?.let { this@HomeFragment.data.addAll(it) }
                        adapter.notifyDataSetChanged()
                        refreshLayout?.refreshComplete()
                    }
                })
    }

    override fun getLayoutId(): Int {
        return com.example.administrator.one.R.layout.fragment_home
    }

    override fun onPageScrollStateChanged(p0: Int) {

    }

    override fun onPageScrolled(p0: Int, p1: Float, p2: Int) {
        Log.e("onPageScrolled", "p0 = $p0 p1= $p1 p2 = $p2")
        when (p0) {
            0 -> {
                refreshLayout?.setDisableLoadMore(true)
                refreshLayout?.setDisableRefresh(p2 > 0)
            }
            data.size - 1 -> {
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