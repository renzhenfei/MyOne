package com.example.administrator.one.model

import com.example.administrator.one.common.api.Constants
import com.google.gson.annotations.SerializedName

data class MusicPageModel(val musicDetail:MusicDetailModel,
                          val musicRelated:MutableList<MusicRelatedModel>,
                          val musicComments:CommentListModel)

data class MusicDetailModel(@SerializedName("id") val musicId:String,
                            @SerializedName("title") val title:String,
                            @SerializedName("cover") val cover:String,
                            @SerializedName("isfirst") val isFirst:String,
                            @SerializedName("story_title") val storyTitle:String,
                            @SerializedName("story") val story:String,
                            @SerializedName("lyric") val lyric:String,
                            @SerializedName("info") val info:String,
                            @SerializedName("platform") val platform:String,
                            @SerializedName("music_id") val musicURL:String,
                            @SerializedName("charge_edt") val chargeEditor:String,
                            @SerializedName("related_to") val relatedTo:String,
                            @SerializedName("web_url") val webURL:String,
                            @SerializedName("praisenum") val praiseNum:Int,
                            @SerializedName("sort") val sort:String,
                            @SerializedName("maketime") val makeTime:String,
                            @SerializedName("last_update_date") val lastUpdateDate:String,
                            @SerializedName("author") val author:AuthorModel,
                            @SerializedName("story_author") val storyAuthor:AuthorModel,
                            @SerializedName("commentnum") val commentNum:Int,
                            @SerializedName("read_num") val readNum:Int,
                            @SerializedName("sharenum") val shareNum:Int,
                            val contentType:Constants.MLBMusicDetailsType):DetailType{
    override fun getType(): Constants.MusicPageType {
        return Constants.MusicPageType.MusicPageTypeDetail
    }

}

data class MusicRelatedModel(@SerializedName("id") val musicId:String,
                             @SerializedName("title") val title:String,
                             @SerializedName("cover") val cover:String,
                             @SerializedName("platform") val platform:String,
                             @SerializedName("musicLongId") val musicLongId:String,
                             @SerializedName("author") val author:AuthorModel):DetailType {
    override fun getType(): Constants.MusicPageType {
        return Constants.MusicPageType.MusicPageTypeRelated
    }
}

interface DetailType{
    fun getType():Constants.MusicPageType
}