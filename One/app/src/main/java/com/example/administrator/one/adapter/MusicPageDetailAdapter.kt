package com.example.administrator.one.adapter

import android.os.Build
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import android.text.Html
import android.text.SpannableString
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.example.administrator.one.R
import com.example.administrator.one.common.api.Constants
import com.example.administrator.one.common.api.Constants.MLBMusicDetailsType.*
import com.example.administrator.one.model.CommentModel
import com.example.administrator.one.model.DetailType
import com.example.administrator.one.model.MusicDetailModel
import com.example.administrator.one.model.MusicRelatedListModel
import com.example.administrator.one.util.CommonUtils
import com.example.administrator.one.util.ImageLoaderUtil
import kotlinx.android.synthetic.main.cell_common_comment.view.*
import kotlinx.android.synthetic.main.cell_page_detail.view.*
import kotlinx.android.synthetic.main.cell_page_related_music.view.*

class MusicPageDetailAdapter(private val pageDetail: MutableList<DetailType>) : RecyclerView.Adapter<MusicPageDetailAdapter.TypeVH>() {
    override fun onCreateViewHolder(p0: ViewGroup, p1: Int): TypeVH {
        val inflater = LayoutInflater.from(p0.context)
        val vh: TypeVH? = when (getItemViewType(p1)) {
            Constants.MusicPageType.MusicPageTypeDetail.ordinal -> DetailVH(inflater.inflate(R.layout.cell_page_detail, p0, false))
            Constants.MusicPageType.MusicPageTypeRelated.ordinal -> RelatedMusicVH(inflater.inflate(R.layout.cell_page_related_music, p0, false))
            Constants.MusicPageType.MusicPageTypeCommentHot.ordinal, Constants.MusicPageType.MusicPageTypeCommentNormal.ordinal -> RelatedMusicVH(inflater.inflate(R.layout.cell_common_comment, p0, false))
            Constants.MusicPageType.MusicPageTypeCommentHeader.ordinal, Constants.MusicPageType.MusicPageTypeCommentFooter.ordinal -> RelatedMusicVH(inflater.inflate(R.layout.cell_common_header_footer, p0, false))
            else -> {
                null
            }
        }
        return vh ?: vh!!
    }

    override fun getItemCount(): Int {
        return 2 + pageDetail.size
    }

    override fun onBindViewHolder(p0: TypeVH, p1: Int) {
        when (getItemViewType(p1)) {
            Constants.MusicPageType.MusicPageTypeDetail.ordinal -> {
                (p0 as DetailVH).configData(pageDetail[p1])
            }
            Constants.MusicPageType.MusicPageTypeRelated.ordinal -> {
                (p0 as RelatedMusicVH).configData(pageDetail[p1])
            }
            Constants.MusicPageType.MusicPageTypeCommentHot.ordinal, Constants.MusicPageType.MusicPageTypeCommentNormal.ordinal -> {
                (p0 as CommentVH).configData(pageDetail[p1])
            }
            Constants.MusicPageType.MusicPageTypeCommentHeader.ordinal, Constants.MusicPageType.MusicPageTypeCommentFooter.ordinal -> {
                (p0 as HeaderFooterVH).configData(pageDetail[p1])
            }
        }
    }

    override fun getItemViewType(position: Int): Int {
        return pageDetail[position].getType().ordinal
    }


    abstract inner class TypeVH(itemView: View) : RecyclerView.ViewHolder(itemView) {
        abstract fun <T> configData(data: T)
    }

    inner class DetailVH(private val rootView: View) : TypeVH(rootView) {

        private var detailModel: MusicDetailModel? = null

        override fun <T> configData(data: T) {
            detailModel = data as MusicDetailModel
            ImageLoaderUtil.displayRoundImage(rootView.context, detailModel?.cover!!, rootView.coverImg)
            ImageLoaderUtil.displayRoundImage(rootView.context, detailModel?.author?.webURL!!, rootView.avatar)
            rootView.authorName.text = detailModel?.author?.userName
            rootView.authorDesc.text = detailModel?.author?.desc
            rootView.title.text = detailModel?.title
            rootView.dateTime.text = CommonUtils.formatTime(detailModel?.makeTime, "MMM dd,yyyy")
            rootView.musicControl.isSelected = false
            showContentWithType(if (detailModel?.contentType == MLBMusicDetailsTypeNone) MLBMusicDetailsTypeStory else detailModel?.contentType!!)
        }

        private fun showContentWithType(type: Constants.MLBMusicDetailsType) {
            var contentStr = ""
            when (type) {
                MLBMusicDetailsTypeNone -> {
                    rootView.contentType.text = "音乐故事"
                    rootView.content.text = ""
                    rootView.storyBtn.isSelected = false
                    rootView.lyricBtn.isSelected = false
                    rootView.aboutBtn.isSelected = false
                }
                MLBMusicDetailsTypeStory -> {
                    rootView.contentType.text = "音乐故事"
                    rootView.storyBtn.isSelected = true
                    rootView.lyricBtn.isSelected = false
                    rootView.aboutBtn.isSelected = false
                    contentStr = detailModel?.story!!
                }
                MLBMusicDetailsTypeLyric -> {
                    rootView.contentType.text = "歌词"
                    rootView.storyBtn.isSelected = false
                    rootView.lyricBtn.isSelected = true
                    rootView.aboutBtn.isSelected = false
                    contentStr = detailModel?.lyric!!
                }
                MLBMusicDetailsTypeInfo -> {
                    rootView.contentType.text = "歌曲信息"
                    rootView.storyBtn.isSelected = false
                    rootView.lyricBtn.isSelected = false
                    rootView.aboutBtn.isSelected = true
                    contentStr = detailModel?.info!!
                }
            }
            if (contentStr.isEmpty()) {
                return
            }
            if (type == MLBMusicDetailsTypeStory){
                rootView.contentTitle.visibility = View.GONE
                rootView.userName.visibility = View.GONE
                //title
                rootView.contentTitle.text = detailModel?.storyTitle
                //username
                rootView.userName.text = detailModel?.storyAuthor?.userName
                //content
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    rootView.content.text = Html.fromHtml(contentStr, Html.FROM_HTML_MODE_COMPACT)
                } else {
                    rootView.content.text = Html.fromHtml(contentStr)
                }
            }else{
                rootView.contentTitle.visibility = View.GONE
                rootView.userName.visibility = View.GONE
                rootView.content.text = contentStr
            }
        }
    }

    inner class RelatedMusicVH(private val rootView: View) : TypeVH(rootView) {
        override fun <T> configData(data: T) {
            val musicRelatedModel = data as MusicRelatedListModel
            rootView.relatedMusicList.layoutManager = LinearLayoutManager(rootView.context,LinearLayoutManager.HORIZONTAL,false)
            rootView.relatedMusicList.adapter = RelatedMusicAdapter(musicRelatedModel.relatedMusicList)
        }
    }

    inner class CommentVH(private val rootView: View) : TypeVH(rootView) {
        override fun <T> configData(data: T) {
            val commentModel = data as CommentModel
            ImageLoaderUtil.displayRoundImage(rootView.context,commentModel.user.webURL,rootView.userAvatarView)
            rootView.userNameLabel.text = commentModel.user.userName.trim()
            rootView.dateLabel.text = CommonUtils.formatTime(commentModel.inputDate,"yyyy.MM.dd")
            rootView.praise.text = commentModel.praiseNum.toString()
            if (commentModel.quote.isNotEmpty()){
                val text = SpannableString(commentModel.toUser.userName.trim())
//                text.
            }
        }
    }

    inner class HeaderFooterVH(rootView: View) : TypeVH(rootView) {
        override fun <T> configData(data: T) {

        }
    }
}