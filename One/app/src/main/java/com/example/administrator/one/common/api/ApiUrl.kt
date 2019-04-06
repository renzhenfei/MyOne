package com.example.administrator.one.common.api

import com.example.administrator.one.model.HomePageModel
import io.reactivex.Observable
import retrofit2.http.GET

interface ApiUrl {

    @GET(Constants.MLBApiHomePageMore)
    fun getRetrofit(): Observable<BaseResponse<MutableList<HomePageModel>>>

}