package com.example.administrator.one.model

import com.google.gson.annotations.SerializedName

/**
 * @"itemId" : @"id",
@"title" : @"title",
@"cover" : @"cover",
@"bottomText" : @"bottom_text",
@"bgColor" : @"bgcolor",
@"pvURL" : @"pv_url"
 */
data class BannerModel(@SerializedName("id") val itemId: String,
                       @SerializedName("title") val title: String,
                       @SerializedName("cover") val cover: String,
                       @SerializedName("bottom_text") val bottomText: String,
                       @SerializedName("bgcolor") val bgColor: String,
                       @SerializedName("pv_url") val pvUrl: String)

data class ReadEssayModel(@SerializedName("content_id") val contentId: String,
                          @SerializedName("hp_title") val title: String,
                          @SerializedName("hp_maketime") val makeTime: String,
                          @SerializedName("guide_word") val guideWord: String,
                          @SerializedName("author") val authors: MutableList<AuthorModel>,
                          @SerializedName("has_audio") val hasAudio: Boolean)

data class ReadSerialModel(@SerializedName("content_id") val id: String,
                           @SerializedName("serial_id") val serialId: String,
                           @SerializedName("number") val number: String,
                           @SerializedName("title") val title: String,
                           @SerializedName("excerpt") val excerpt: String,
                           @SerializedName("read_num") val readNum: String,
                           @SerializedName("maketime") val makeTime: String,
                           @SerializedName("author") val author: AuthorModel,
                           @SerializedName("has_audio") val hasAudio: Boolean)

data class ReadQuestionModel(@SerializedName("question_id") val questionId: String,
                             @SerializedName("question_title") val questionTitle: String,
                             @SerializedName("answer_title") val answerTitle: String,
                             @SerializedName("answer_content") val answerContent: String,
                             @SerializedName("question_makettime") val questionMakeTime: String)

data class ReadIndexModel(val essay: MutableList<ReadEssayModel>,
                          val serial: MutableList<ReadSerialModel>,
                          val question: MutableList<ReadQuestionModel>)