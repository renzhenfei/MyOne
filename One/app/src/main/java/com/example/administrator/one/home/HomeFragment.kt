package com.example.administrator.one.home

import android.view.View
import com.example.administrator.one.BaseFragment
import com.example.administrator.one.R
import com.example.administrator.one.adapter.HomePagerAdapter
import com.example.administrator.one.common.api.API
import com.example.administrator.one.common.api.ApiUrl
import com.example.administrator.one.common.api.BaseObserver
import com.example.administrator.one.model.HomePageModel
import com.trello.rxlifecycle2.android.FragmentEvent
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import kotlinx.android.synthetic.main.fragment_home.view.*

class HomeFragment : BaseFragment() {

    private val data = mutableListOf<HomePageModel>()
    private val adapter = HomePagerAdapter(data)
    companion object {
        val TAG = this::class.java.name
        fun newInstance(): HomeFragment {
            return HomeFragment()
        }
    }

    override fun initView(rootView: View) {
        rootView.vp.adapter = adapter
    }

    override fun initData() {
        API.retrofit?.create(ApiUrl::class.java)
                ?.getRetrofit()
                //绑定线程
                ?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
                //绑定生命周期
                ?.compose(bindUntilEvent(FragmentEvent.DESTROY))
                ?.subscribe(object : BaseObserver<MutableList<HomePageModel>>(){
                    override fun onFailure(code: Int?) {

                    }

                    override fun onSuccess(data: MutableList<HomePageModel>?) {
                        this@HomeFragment.data.clear()
                        data?.let { this@HomeFragment.data.addAll(it) }
                        adapter.notifyDataSetChanged()
                    }
                } )
    }

    override fun getLayoutId(): Int {
        return R.layout.fragment_home
    }

}