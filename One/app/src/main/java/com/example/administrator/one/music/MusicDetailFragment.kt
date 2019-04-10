package com.example.administrator.one.music

import android.os.Bundle
import android.support.v7.widget.LinearLayoutManager
import android.view.View
import com.example.administrator.one.BaseFragment
import com.example.administrator.one.R
import com.example.administrator.one.adapter.MusicPageDetailAdapter
import com.example.administrator.one.common.api.API
import com.example.administrator.one.common.api.ApiUrl
import com.example.administrator.one.common.api.BaseObserver
import com.example.administrator.one.common.api.Constants
import com.example.administrator.one.model.*
import com.example.administrator.one.util.DefaultItemDecoration
import com.trello.rxlifecycle2.android.FragmentEvent
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import kotlinx.android.synthetic.main.fragment_music_detail.view.*

class MusicDetailFragment : BaseFragment() {

    private val data:MutableList<DetailType> = mutableListOf()
    private val adapter:MusicPageDetailAdapter = MusicPageDetailAdapter(data)

    companion object {

        private const val MUSIC_ID = "music_id"

        @JvmStatic
        fun newInstance(musicId:String):MusicDetailFragment{
            val b = Bundle()
            b.putString(MUSIC_ID,musicId)
            val fragment  = MusicDetailFragment()
            fragment.arguments = b
            return fragment
        }
    }

    override fun getLayoutId(): Int {
        return R.layout.fragment_music_detail
    }

    override fun initView(rootView: View) {
        rootView.list.addItemDecoration(DefaultItemDecoration(activity!!))
        rootView.list.layoutManager = LinearLayoutManager(activity,LinearLayoutManager.VERTICAL,false)
        rootView.list.adapter = adapter
    }

    override fun initData() {
        val musicId = arguments?.getString(MUSIC_ID)
        API.retrofit?.create(ApiUrl::class.java)
                ?.getMusicDetailId(musicId!!)
                //绑定线程
                ?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
                //绑定生命周期
                ?.compose(bindUntilEvent(FragmentEvent.DESTROY))
                ?.subscribe(object : BaseObserver<MusicDetailModel>() {
                    override fun onFailure(code: Int?) {
                    }

                    override fun onSuccess(data: MusicDetailModel?) {
                        if (data != null){
                            this@MusicDetailFragment.data.add(data)
                            adapter.notifyDataSetChanged()
                            getRelatedMusicData(musicId)
                        }
                    }
                })

    }

    private fun getRelatedMusicData(musicId: String) {
        API.retrofit?.create(ApiUrl::class.java)
                ?.getMusicDetailsRelatedMusicsById(musicId)
                //绑定线程
                ?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
                //绑定生命周期
                ?.compose(bindUntilEvent(FragmentEvent.DESTROY))
                ?.subscribe(object : BaseObserver<MutableList<MusicRelatedModel>>() {
                    override fun onFailure(code: Int?) {
                        getMusicCommentData(musicId)
                    }

                    override fun onSuccess(data: MutableList<MusicRelatedModel>?) {
                        if (data != null && data.isNotEmpty()){
                            this@MusicDetailFragment.data.add(MusicRelatedListModel(data))
                            adapter.notifyDataSetChanged()
                        }
                        getMusicCommentData(musicId)
                    }
                })
    }

    private fun getMusicCommentData(musicId: String) {
        API.retrofit?.create(ApiUrl::class.java)
                ?.getMusicPraiseAndTimeComments(musicId,"")
                //绑定线程
                ?.subscribeOn(Schedulers.io())
                ?.observeOn(AndroidSchedulers.mainThread())
                //绑定生命周期
                ?.compose(bindUntilEvent(FragmentEvent.DESTROY))
                ?.subscribe(object : BaseObserver<MutableList<CommentModel>>() {
                    override fun onFailure(code: Int?) {
                    }

                    override fun onSuccess(data: MutableList<CommentModel>?) {
                        if (data != null && data.isNotEmpty()){
                            var flag = false
                            data.filter { it.getType() == Constants.MusicPageType.MusicPageTypeCommentHot }.forEach {
                                if (!flag){
                                this@MusicDetailFragment.data.add(HeaderFooterModel("热门评论列表",Constants.MusicPageType.MusicPageTypeCommentHeader.ordinal))
                                    flag = true
                                }
                                this@MusicDetailFragment.data.add(it)
                            }
                            flag = false
                            data.filter { it.getType() != Constants.MusicPageType.MusicPageTypeCommentHot }.forEach {
                                if (!flag){
                                    this@MusicDetailFragment.data.add(HeaderFooterModel("评论列表",Constants.MusicPageType.MusicPageTypeCommentFooter.ordinal))
                                    flag = true
                                }
                                this@MusicDetailFragment.data.add(it)
                            }
                            adapter.notifyDataSetChanged()
                        }
                        getMusicCommentData(musicId)
                    }
                })
    }
}