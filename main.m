//
//  main.m
//  CopyOnePics
//
//  Created by zhenfei ren on 2019/4/1.
//  Copyright © 2019 zhenfei ren. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *srcPath = @"/Users/zhenfeiren/Desktop/MyOne/MyOne/MyOne/Assets.xcassets";
        NSString *desPath = @"/Users/zhenfeiren/Downloads/myone_pics";
        copyFileImg(srcPath, desPath, fileManager);
    }
    return 0;
}

int copyFileImg(NSString *srcPath,NSString *desPath,NSFileManager *fileManager){
    BOOL isDir;
    NSArray *dirs = [fileManager contentsOfDirectoryAtPath:srcPath error:nil];
    for (NSString *dir in dirs) {
        NSString *file = [srcPath stringByAppendingPathComponent:dir];
        [fileManager fileExistsAtPath:file isDirectory:&isDir];
        if (isDir) {
            //文件夹
            copyFileImg(file, desPath, fileManager);
        }else{
            //图片文件 copy到目的文件夹
            NSFileHandle *srcHandle = [NSFileHandle fileHandleForReadingAtPath:file];
            NSData *imgData = [srcHandle readDataToEndOfFile];
            NSString *x2 = [desPath stringByAppendingPathComponent:@"pic-2x"];
            NSString *x3 = [desPath stringByAppendingPathComponent:@"pic-3x"];
            if ([[file pathExtension] isEqualToString:@"png"]) {
                if ([file containsString:@"2x"]) {
                    //2x pic-3x
                    if (![fileManager fileExistsAtPath:x3]) {
                        [fileManager createDirectoryAtPath:x3 withIntermediateDirectories:YES attributes:nil error:nil];
                    }
                    NSString *desFile = [x3 stringByAppendingPathComponent:[file lastPathComponent]];
                    NSFileHandle *desHandle = [NSFileHandle fileHandleForWritingAtPath:desFile];
                    if (![fileManager fileExistsAtPath:desFile]) {
                        [fileManager createFileAtPath:desFile contents:nil attributes:nil];
                    }
                    [desHandle writeData:imgData];
                    [desHandle closeFile];
                }else{
                    //1x pic-2x
                    if (![fileManager fileExistsAtPath:x2]) {
                        [fileManager createDirectoryAtPath:x2 withIntermediateDirectories:YES attributes:nil error:nil];
                    }
                    NSString *desFile = [x2 stringByAppendingPathComponent:[file lastPathComponent]];
                    NSFileHandle *desHandle = [NSFileHandle fileHandleForWritingAtPath:desFile];
                    if (![fileManager fileExistsAtPath:desFile]) {
                        [fileManager createFileAtPath:desFile contents:nil attributes:nil];
                    }
                    [desHandle writeData:imgData];
                    [desHandle closeFile];
                }
            }
        }
        NSLog(@"%@",file);
    }
    return 0;
}
