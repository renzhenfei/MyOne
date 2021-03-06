package com.example.administrator.one.model

import com.example.administrator.one.common.api.Constants
import com.google.gson.annotations.SerializedName

data class AuthorModel(@SerializedName("user_id") val userId: String,
                       @SerializedName("user_name") val userName: String,
                       @SerializedName("web_url") val webURL: String,
                       @SerializedName("desc") val desc: String)

data class UserModel(@SerializedName("user_id") val userId:String,
                     @SerializedName("user_name") val userName:String,
                     @SerializedName("web_url") val webURL:String,
                     @SerializedName("desc") val desc:String)

data class CommentModel(@SerializedName("id") val commentId:String,
                        @SerializedName("quote") val quote:String,
                        @SerializedName("content") val content:String,
                        @SerializedName("praisenum") val praiseNum:Int,
                        @SerializedName("input_date") val inputDate:String,
                        @SerializedName("user") val user:UserModel,
                        @SerializedName("touser") val toUser:UserModel,
                        @SerializedName("type") private val commentType:Int):DetailType{

    var numberOflines:Int = 0
    var unfolded:Boolean = false//是否已经展开
    var lastHotComment:Boolean = false

    override fun getType(): Constants.MusicPageType {
        return if (commentType == 0) Constants.MusicPageType.MusicPageTypeCommentHot else Constants.MusicPageType.MusicPageTypeCommentNormal
    }
}

data class CommentListModel(@SerializedName("count") val count:Int,
                            @SerializedName("data") val comments:MutableList<CommentModel>,
                            val hotComments:MutableList<CommentModel>)

data class HeaderFooterModel(val content: String,val type : Int) : DetailType {
    override fun getType(): Constants.MusicPageType {
        return Constants.MusicPageType.values()[type]
    }
}