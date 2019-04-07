package com.example.administrator.one.read

import android.graphics.Color
import android.support.v4.view.ViewPager
import android.view.View
import com.example.administrator.one.BaseFragment
import com.example.administrator.one.R
import com.example.administrator.one.adapter.ReadPageAdapter
import com.example.administrator.one.common.api.API
import com.example.administrator.one.common.api.ApiUrl
import com.example.administrator.one.common.api.BaseObserver
import com.example.administrator.one.model.BannerModel
import com.example.administrator.one.model.ReadIndexModel
import com.example.administrator.one.util.GlideImageLoader
import com.trello.rxlifecycle2.android.FragmentEvent
import com.youth.banner.Banner
import com.youth.banner.BannerConfig
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import kotlinx.android.synthetic.main.fragment_read.view.*
import me.dkzwm.widget.srl.HorizontalSmoothRefreshLayout
import me.dkzwm.widget.srl.RefreshingListenerAdapter
import me.dkzwm.widget.srl.extra.footer.MaterialFooter
import me.dkzwm.widget.srl.extra.header.MaterialHeader
import me.dkzwm.widget.srl.indicator.DefaultIndicator

class ReadFragment : BaseFragment(), ViewPager.OnPageChangeListener {

    private val imgUrls = mutableListOf<String>()
    private var banner: Banner? = null
    private val listData: MutableList<MutableList<Any>> = mutableListOf()
    private val adapter: ReadPageAdapter? = ReadPageAdapter(listData)
    private var refreshLayout: HorizontalSmoothRefreshLayout? = null
    private var vp: ViewPager? = null

    companion object {
        val TAG = this::class.java.name
        fun newInstance(): ReadFragment {
            return ReadFragment()
        }
    }

    override fun initView(rootView: View) {
        vp = rootView.vp0
        banner = rootView.banner
        banner?.setImages(imgUrls)
                ?.setImageLoader(GlideImageLoader())
                ?.setBannerStyle(BannerConfig.CIRCLE_INDICATOR)
                ?.isAutoPlay(true)
                ?.setDelayTime(2_000)
                ?.setIndicatorGravity(BannerConfig.CENTER)
                ?.start()
        vp?.addOnPageChangeListener(this)
        refreshLayout = rootView.refreshLayout
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
        vp?.adapter = adapter
    }

    override fun initData() {
        API.retrofit?.create(ApiUrl::class.java)
                ?.getReadingCarousel()
                //绑定线程
                ?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
                //绑定生命周期
                ?.compose(bindUntilEvent(FragmentEvent.DESTROY))
                ?.subscribe(object : BaseObserver<MutableList<BannerModel>>() {
                    override fun onFailure(code: Int?) {

                    }

                    override fun onSuccess(data: MutableList<BannerModel>?) {
                        val imgUrls = data?.map { it.cover }
                        banner?.update(imgUrls)
                    }
                })
        API.retrofit?.create(ApiUrl::class.java)
                ?.getReadingIndex()
                //绑定线程
                ?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
                //绑定生命周期
                ?.compose(bindUntilEvent(FragmentEvent.DESTROY))
                ?.subscribe(object : BaseObserver<ReadIndexModel>() {
                    override fun onFailure(code: Int?) {
                    }

                    override fun onSuccess(data: ReadIndexModel?) {
                        processData(data)
                    }

                })
    }

    private fun processData(indexModel: ReadIndexModel?) {
        val essay = indexModel?.essay
        val serial = indexModel?.serial
        val question = indexModel?.question
        val count = Math.max(Math.max(essay?.size!!, serial?.size!!), question?.size!!)
        listData.clear()
        for (i in 0..count) {
            val list = mutableListOf<Any>()
            if (i < essay.size)
                list.add(essay[i])
            if (i < serial.size)
                list.add(serial[i])
            if (i < question.size)
                list.add(question[i])
            listData.add(list)
        }
        adapter?.notifyDataSetChanged()
    }

    override fun getLayoutId(): Int {
        return R.layout.fragment_read
    }

    override fun onStart() {
        super.onStart()
        view?.banner?.startAutoPlay()
    }

    override fun onStop() {
        super.onStop()
        view?.banner?.stopAutoPlay()
    }

    override fun onPageScrollStateChanged(p0: Int) {
    }

    override fun onPageScrolled(p0: Int, p1: Float, p2: Int) {
        when (p0) {
            0 -> {
                refreshLayout?.setDisableLoadMore(true)
                refreshLayout?.setDisableRefresh(p2 > 0)
            }
            listData.size - 1 -> {
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