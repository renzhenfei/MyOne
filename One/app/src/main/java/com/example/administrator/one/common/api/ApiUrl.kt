package com.example.administrator.one.common.api

import com.example.administrator.one.model.*
import io.reactivex.Observable
import retrofit2.http.GET
import retrofit2.http.Path

interface ApiUrl {

    @GET(Constants.MLBApiHomePageMore)
    fun getRetrofit(): Observable<BaseResponse<MutableList<HomePageModel>>>

    @GET(Constants.MLBApiReadingCarousel)
    fun getReadingCarousel(): Observable<BaseResponse<MutableList<BannerModel>>>

    @GET(Constants.MLBApiReadingIndex)
    fun getReadingIndex(): Observable<BaseResponse<ReadIndexModel>>

    @GET(Constants.MLBApiMusicIdList)
    fun getMusicIdList(): Observable<BaseResponse<MutableList<String>>>

    @GET(Constants.MLBApiMusicDetailsById)
    fun getMusicDetailId(@Path("musicId") musicId: String): Observable<BaseResponse<MusicDetailModel>>

    @GET(Constants.MLBApiGetRelateds)
    fun getMusicDetailsRelatedMusicsById(@Path("musicId") musicId:String,
                                         @Path("music") music : String = Constants.MLBApiMusic):Observable<BaseResponse<MutableList<MusicRelatedModel>>>

    @GET(Constants.MLBApiGetPraiseAndTimeComments)
    fun getMusicPraiseAndTimeComments(@Path("musicId") musicId:String,
                                      @Path("lastCommentId") lastCommentId:String?,
                                      @Path("music") music:String = Constants.MLBApiMusic):Observable<BaseResponse<MutableList<CommentModel>>>
}