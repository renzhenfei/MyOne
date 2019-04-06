package com.example.administrator.one.common.api

object Constants {
    //region  API常量
    //服务器地址
    const val MLBApiServerAddress = "http://v3.wufazhuce.com:8000/api/"
    // 获取文章详情
    const val MLBApiGetReadDetails = "/%@/%@"
    // 获取评论列表
    const val MLBApiGetPraiseComments = "/comment/praise/%@/%@/%@"
    const val MLBApiGetTimeComments = "/comment/time/%@/%@/%@"
    const val MLBApiGetPraiseAndTimeComments = "/comment/praiseandtime/%@/%@/%@"
    // 搜索
    const val MLBApiSearching = "/search/%@/%@"
    // 作者/音乐人
    const val MLBApiAuthor = "author"
    // 获取相关列表
    const val MLBApiGetRelateds = "/related/%@/%@"
    //region home
    // 首页图文
    const val MLBApiHomePage = "hp"
    const val MLBApiHomePageMore = "hp/more/0"
    const val MLBApiHomePageByMonth = "/hp/bymonth/%@"
    //endregion
    //region read
    // 阅读
    const val MLBApiReading = "reading"
    // 短篇
    const val MLBApiEssay = "essay"
    // 连载
    const val MLBApiSerial = "serial"
    const val MLBApiSerialContent = "serialcontent"
    // 连载列表
    const val MLBApiSerialList = "/serial/list/%@"
    // 问题
    const val MLBApiQuestion = "question"
    // 阅读头部轮播列表
    const val MLBApiReadingCarousel = "/reading/carousel"
    // 阅读文章索引列表
    const val MLBApiReadingIndex = "/reading/index"
    // 短篇文章详情
    const val MLBApiEssayDetailsById = "/essay/%@"
    // 月的文章列表
    const val MLBApiReadByMonth = "/%@/bymonth/%@"
    //endregion
    //region music
    // 音乐
    const val MLBApiMusic  = "music"
    // 音乐Id列表
    const val MLBApiMusicIdList  = "/music/idlist/0"
    // 音乐详情
    const val MLBApiMusicDetailsById  = "/music/detail/%@"
    // 月的音乐列表
    const val MLBApiMusicByMonth  = "/music/bymonth/%@"
    //endregion
    // region movie
    // 电影
    const val MLBApiMovie  = "movie"
    // 电影列表
    const val MLBApiMovieList  = "/movie/list/%ld"
    // 电影详情
    const val MLBApiMovieDetails  = "/movie/detail/%@"
    // 电影故事
    const val MLBApiMovieStories  = "/movie/%@/story/%@/%@"
    // 电影短评
    const val MLBApiMovieReviews  = "/movie/%@/review/%@/%@"
    //endregion
    //endregion

    //region 常量字符串
    const val BAD_NETWORK = "网络连接失败"
    const val SERVER_ERROR = "服务器连接失败"
    //endregion

    //region 枚举
    enum class MLBActionType {
        MLBActionTypeDiary,
        MLBActionTypePraise,
        MLBActionTypeMore,
    }

    enum class MLBReadType {
        MLBReadTypeEssay,
        MLBReadTypeSerial,
        MLBReadTypeQuestion,
    }

    enum class MLBUserType {
        MLBUserTypeMe,
        MLBUserTypeOthers,
    }

    enum class MLBSearchType {
        MLBSearchTypeHome,
        MLBSearchTypeRead,
        MLBSearchTypeMusic,
        MLBSearchTypeMovie,
        MLBSearchTypeAuthor,
    }

    enum class MLBMusicDetailsType {
        MLBMusicDetailsTypeNone,
        MLBMusicDetailsTypeStory,
        MLBMusicDetailsTypeLyric,
        MLBMusicDetailsTypeInfo,
    }
    //endregion
}