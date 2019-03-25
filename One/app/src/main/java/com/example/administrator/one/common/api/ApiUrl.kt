package com.example.administrator.one.common.api

import io.reactivex.Observable
import retrofit2.http.GET

interface ApiUrl {

    @GET(Constants.RETROFIT)
    fun getRetrofit(): Observable<BaseResponse<Any>>

}