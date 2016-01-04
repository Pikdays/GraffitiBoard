//
//  ImageManger.h
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface ImageManger : NSObject

/**
 *  获取图片管理者
 *
 *  @return 图片管理者
 */
+ (instancetype)sharedImageManger;

/**
 *  添加图片
 *
 *  @param image 图片
 */
- (void)addImage:(UIImage *)image;

/**
 *  是否可以撤销
 *
 *  @return 是否
 */
- (BOOL)canUndo;

/**
 *  获取撤销操作的图片
 *
 *  @return 图片
 */
- (UIImage *)imageForUndo;

/**
 *  是否可以恢复
 *
 *  @return 是否
 */
- (BOOL)canRedo;

/**
 *  获取恢复操作的图片
 *
 *  @return 图片
 */
- (UIImage *)imageForRedo;

/**
 *  移除所有图片
 */
- (void)removeAllImages;

@end
