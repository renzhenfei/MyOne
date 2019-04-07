package com.example.administrator.one.model

import com.google.gson.annotations.SerializedName

data class AuthorModel(@SerializedName("user_id") val userId: String,
                       @SerializedName("user_name") val userName: String,
                       @SerializedName("web_url") val webURL: String,
                       @SerializedName("desc") val desc: String)