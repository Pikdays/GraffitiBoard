//
//  PaintingLayer.h
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@import UIKit;

@protocol PaintBrush;

@interface PaintingLayer : CALayer

/**
 *  能否撤销
 */
@property (nonatomic, readonly) BOOL canUndo;

/**
 *  能否恢复
 */
@property (nonatomic, readonly) BOOL canRedo;

/**
 *  画刷对象
 */
@property (nonatomic, strong) id<PaintBrush> paintBrush;

/**
 *  触摸事件响应,于四个触摸事件发生时调用此方法并将 UITouch 传入
 *
 *  @param touch Touch
 */
- (void)touchAction:(UITouch *)touch;

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

@end
