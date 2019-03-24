//
//  MLBTabBarController.m
//  MyOne
//
//  Created by zhenfei ren on 2019/3/15.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import "MLBTabBarController.h"
#import "MLBMusicViewController.h"
#import "MLBMovieViewController.h"
#import "MLBReadViewController.h"
#import "MLBHomeViewController.h"
@implementation MLBTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        MLBMusicViewController *musicVC = [[MLBMusicViewController alloc] init];
        UINavigationController *musicNav = [[UINavigationController alloc] initWithRootViewController:musicVC];
        musicNav.title = MLBMusicTitle;
        MLBMovieViewController *movieVC = [[MLBMovieViewController alloc] init];
        UINavigationController *movieNav = [[UINavigationController alloc] initWithRootViewController:movieVC];
        movieNav.title = MLBMovieTitle;
        MLBReadViewController *readVC = [[MLBReadViewController alloc] init];
        UINavigationController *readNav = [[UINavigationController alloc] initWithRootViewController:readVC];
        readNav.title = MLBReadTitle;
        MLBHomeViewController *homeVC = [[MLBHomeViewController alloc] init];
        UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
        homeNav.title = MLBHomeTitle;
        [self setViewControllers:@[homeNav,readNav,musicNav,movieNav]];
        [self setupTabBar];
        [self createCacheFilesFolder];
        
    }
    return self;
}

-(void)setupTabBar{
    NSArray *tabBarItemImageNames = @[@"tab_home", @"tab_read", @"tab_music", @"tab_movie"];
    NSInteger index = 0;
    for (UIViewController *vc in self.viewControllers) {
        NSString *normalImageName = [NSString stringWithFormat:@"%@_normal",[tabBarItemImageNames objectAtIndex:index]];
        NSString *selectedImageName = [NSString stringWithFormat:@"%@_selected",tabBarItemImageNames[index]];
        UIImage *normalImage = [UIImage imageNamed:normalImageName];
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        vc.tabBarItem.image = normalImage;
        vc.tabBarItem.selectedImage = selectedImage;
        index++;
    }
}

-(void)createCacheFilesFolder{
    NSString *cacheFileFolderPath = [NSString stringWithFormat:@"%@/%@",DocumentsDirectory,MLBCacheFilesFolderName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL dirExist = [fileManager fileExistsAtPath:cacheFileFolderPath isDirectory:&isDir];
    if (!(isDir && dirExist)) {
        [fileManager createDirectoryAtPath:cacheFileFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

@end
