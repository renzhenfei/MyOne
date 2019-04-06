package com.example.administrator.one.common.api

import com.jakewharton.retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object API {

    var retrofit: Retrofit? = null

    init {
        retrofit = Retrofit.Builder()
                .baseUrl(Constants.MLBApiServerAddress)
                .addConverterFactory(GsonConverterFactory.create())
                .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                .build()
    }

}