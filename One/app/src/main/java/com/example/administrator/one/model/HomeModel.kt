package com.example.administrator.one.model

import com.google.gson.annotations.SerializedName

/**
 * {@"contentId" : @"hpcontent_id",
@"content" : @"hp_content",
@"title" : @"hp_title",
@"imageURL" : @"hp_img_url",
@"imageOriginalURL" : @"hp_img_original_url",
@"authorId" : @"author_id",
@"authorName" : @"hp_author",
@"iPadURL" : @"ipad_url",
@"makeTime" : @"hp_makettime",
@"lastUpdateDate" : @"last_update_date",
@"webURL" : @"web_url",
@"wbImageURL" : @"wb_img_url",
@"praiseNum" : @"praisenum",
@"shareNum" : @"sharenum",
@"commentNum" : @"commentnum"}
 */
class HomePageModel(@SerializedName("hpcontent_id") val contentId:String,
                    @SerializedName("hp_content") val content:String,
                    @SerializedName("hp_img_url") val imageURL:String,
                    @SerializedName("hp_title") val title:String,
                    @SerializedName("hp_img_original_url") val imageOriginalURL:String,
                    @SerializedName("author_id") val authorId:String,
                    @SerializedName("hp_author") val authorName:String,
                    @SerializedName("ipad_url") val iPadURL:String,
                    @SerializedName("hp_makettime") val makeTime:String,
                    @SerializedName("last_update_date") val lastUpdateDate:String,
                    @SerializedName("web_url") val webURL:String,
                    @SerializedName("wb_img_url") val wbImageURL:String,
                    @SerializedName("praisenum") val praiseNum:Int,
                    @SerializedName("sharenum") val shareNum:Int,
                    @SerializedName("commentnum") val commentNum:Int)