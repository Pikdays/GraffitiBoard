//
//  PaintingView.h
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaintBrush;

@interface PaintingView : UIView

/**
 *  背景照片
 */
@property (nonatomic, strong) UIImage *backgroundImage;

/**
 *  画刷
 */
@property (nonatomic, strong) id<PaintBrush> paintBrush;

/**
 *  能否撤销
 */
@property (nonatomic, readonly) BOOL canUndo;

/**
 *  能否恢复
 */
@property (nonatomic, readonly) BOOL canRedo;

/**
 *  清屏
 */
- (void)clear;

/**
 *  撤销
 */
- (void)undo;

/**
 *  恢复
 */
- (void)redo;

/**
 *  保存画板内容到系统相册
 */
- (void)saveToPhotosAlbum;

@end
