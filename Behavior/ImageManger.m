//
//  ImageManger.m
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import "ImageManger.h"

/**
 *  自己的图片缓存文件夹路径
 *
 *  @return 图片缓存路径
 */
static inline NSString * ImageCachesPath()
{
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
            stringByAppendingPathComponent:@"ImageCaches"];
}

/**
 *  指定缓存文件索引并生成保存路径
 *
 *  @param imageIndex 文件索引
 *
 *  @return 图片保存路径
 */
static inline NSString * ImageCachePathForIndex(NSInteger imageIndex)
{
    return [ImageCachesPath() stringByAppendingPathComponent:
            [NSString stringWithFormat:@"%ld.png", (long)(imageIndex)]];
}

/**
 *  无效索引
 */
static const NSInteger kInvalidIndex = -1;


@interface ImageManger ()

/**
 *  当前图片索引
 */
@property (nonatomic) NSInteger imageIndex;

/**
 *  图片总数
 */
@property (nonatomic) NSUInteger totalOfImages;

/**
 *  读写图片的串行队列
 */
@property (nonatomic, strong) dispatch_queue_t imageIOQueue;

@end

@implementation ImageManger

#pragma mark - 获取图片管理者

+ (instancetype)sharedImageManger
{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
    });
    return sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedImageManger];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _imageIndex   = kInvalidIndex;
        _imageIOQueue = dispatch_queue_create("com.Jessica.imageIOQueue", DISPATCH_QUEUE_SERIAL);
        [[NSFileManager defaultManager] createDirectoryAtPath:ImageCachesPath()
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
    return self;
}

#pragma mark - 添加图片

- (void)addImage:(UIImage *)image
{
    self.totalOfImages = ++self.imageIndex + 1;
    
    // 后台写入硬盘.
    NSInteger index = self.imageIndex;
    dispatch_async(self.imageIOQueue, ^{
        [UIImagePNGRepresentation(image) writeToFile:ImageCachePathForIndex(index) atomically:YES];
    });
}

#pragma mark - 撤销

- (BOOL)canUndo
{
    return self.imageIndex >= 0;
}

- (UIImage *)imageForUndo
{
    if (![self canUndo]) return nil;
    
    if (--self.imageIndex == kInvalidIndex) return nil;
    
    __block UIImage *image;
    dispatch_sync(self.imageIOQueue, ^{
        image = [UIImage imageWithContentsOfFile:ImageCachePathForIndex(self.imageIndex)];
    });
    return image;
}

#pragma mark - 恢复

- (BOOL)canRedo
{
    return ((NSUInteger)self.imageIndex + 1) < self.totalOfImages;
}

- (UIImage *)imageForRedo
{
    if (![self canRedo]) return nil;
    
    __block UIImage *image;
    dispatch_sync(self.imageIOQueue, ^{
        image = [UIImage imageWithContentsOfFile:ImageCachePathForIndex(++self.imageIndex)];
    });
    return image;
}

#pragma mark - 移除所有图片

- (void)removeAllImages
{
    self.imageIndex = kInvalidIndex;
    
    dispatch_sync(self.imageIOQueue, ^{
        [[NSFileManager defaultManager] removeItemAtPath:ImageCachesPath() error:NULL];
        [[NSFileManager defaultManager] createDirectoryAtPath:ImageCachesPath()
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    });
}
@end
