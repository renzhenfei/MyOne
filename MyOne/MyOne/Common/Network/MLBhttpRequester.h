//
//  MLBhttpRequester.h
//  MyOne
//
//  Created by zhenfei ren on 2019/2/24.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailBlock)(NSError *error);

@interface MLBhttpRequester : NSObject
#pragma mark - get Api String

+(NSString *)apoStringForReadDetailsWithReadType:(MLBReadType)readType;

+(NSString *)apiStringForReadWithReadType:(MLBReadType)readType;

+(NSString *)apiStringForMusic;

+(NSString *)apiStringForMovie;

+(NSString *)apiStringForSearchWithSearchType:(MLBSearchType)type;

#pragma mark - Common

+(void)requestPraiseCommentWithType:(NSString *)type itemId:(NSString *)itemId firstItemId:(NSString *)firstItemId success:(SuccessBlock)successBlock fali:(FailBlock)failBlock;

+(void)requestTimeCommentsWithType:(NSString *)type itemId:(NSString *)itemId firstItemId:(NSString *)firstItemId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

+(void)requestPraiseAndTimeCommentWithType:(MLBReadType)readType itemId:(NSString *)itemId lastCommentId:(NSString *)lastCommentId success:(SuccessBlock)successBlock fali:(FailBlock)failBlock;

+(void)requestReeadDetailsWithType:(NSString *)type itemId:(NSString *)itemId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

+(void)requestRelatedWithType:(NSString *)type itemId:(NSString *)itemId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

//搜索
+(void)searchWithType:(NSString *)type kekywords:(NSString *)kekywords ssuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

#pragma mark - Home Page

//首页图文列表
+(void)requestHomeMoreWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

//首页指定月份的图文列表
+(void)requestHomeByMonthWithPeriod:(NSString *)period success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

#pragma mark Read

//头部轮播图列表
+(void)requestReadCarouseWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

//头部轮播详情
+(void)requestReadCarouseDetailsById:(NSString *) carouselId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

//文章列表
+(void)requestReadIndexWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

//短篇文章详情
+(void)requestEssayDetailsById:(NSString *)essayId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

//短篇文章评论列表
+(void)requestEssayCommentById:(NSString *)essayId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

//短篇文章相关列表
+(void)requestEssayRealatedsById:(NSString *)essayId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

//连载文章评论列表
+ (void)requestSerialListById:(NSString *)serialId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

// 指定月份的短篇文章列表
+ (void)requestEssayByMonthWithPeriod:(NSString *)period success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

// 指定月份的连载文章列表
+ (void)requestSerialByMonthWithPeriod:(NSString *)period success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

// 指定月份的问题列表
+ (void)requestQuestionByMonthWithPeriod:(NSString *)period success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

#pragma mark - Music

// 音乐 ID 列表
+ (void)requestMusicIdListWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

// 音乐详情
+ (void)requestMusicDetailsById:(NSString *)musicId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

// 音乐详情评论点赞数降序排序列表
+ (void)requestMusicDetailsPraiseCommentsById:(NSString *)musicId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

// 音乐详情相似歌曲列表
+ (void)requestMusicDetailsRelatedMusicsById:(NSString *)musicId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

// 指定月份的音乐列表
+ (void)requestMusicByMonthWithPeriod:(NSString *)period success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

// 获取音乐的评论列表
+ (void)requestMusicPraiseAndTimeCommentsWithItemId:(NSString *)itemId lastCommentId:(NSString *)lastCommentId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

#pragma mark - Movie

// 获取电影列表
+ (void)requestMovieListWithOffer:(NSInteger)offset success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

// 获取电影详情
+ (void)requestMovieDetailsById:(NSString *)movieId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

// 获取电影故事列表
+ (void)requestMovieDetailsMovieStoriesById:(NSString *)movieId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

+ (void)requestMovieStoriesById:(NSString *)movieId firstItemId:(NSString *)firstItemId forDetails:(BOOL)forDetails success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

// 获取电影短评列表
+ (void)requestMovieDetailsMovieReviewsById:(NSString *)movieId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

+ (void)requestMovieReviewsById:(NSString *)movieId firstItemId:(NSString *)firstItemId forDetails:(BOOL)forDetails success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

// 获取电影评论列表
+ (void)requestMovieDetailsPraiseCommentsById:(NSString *)movieId success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
@end


















