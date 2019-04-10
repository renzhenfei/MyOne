package com.example.administrator.one.music

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

class MusicFragment : BaseFragment() {
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
        rootView.vp.adapter = adapter
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
                        }
                    }
                })
    }

    override fun getLayoutId(): Int {
        return R.layout.fragment_music
    }
}