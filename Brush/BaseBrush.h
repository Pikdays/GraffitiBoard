//
//  BaseBrush.h
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaintBrush.h"

/**
 *  涂鸦工具
 */
typedef NS_ENUM(NSUInteger, BrushType) {
    /**
     *  画笔
     */
    BrushTypePencil,
    /**
     *  橡皮
     */
    BrushTypeEraser,
    /**
     *  直线
     */
    BrushTypeLine,
    /**
     *  虚线
     */
    BrushTypeDashLine,
    /**
     *  矩形
     */
    BrushTypeRectangle,
    /**
     *  方形
     */
    BrushTypeSquare,
    /**
     *  椭圆
     */
    BrushTypeEllipse,
    /**
     *  正圆
     */
    BrushTypeCircle,
    /**
     *  箭头
     */
    BrushTypeArrow,
};

@interface BaseBrush : NSObject <PaintBrush>

/**
 *  初始点
 */
@property (nonatomic, readonly) CGPoint startPoint;

/**
 *  上一点
 */
@property (nonatomic, readonly) CGPoint previousPoint;

/**
 *  当前点
 */
@property (nonatomic, readonly) CGPoint currentPoint;

/**
 *  配置上下文
 *
 *  @param context 上下文
 */
- (void)configureContext:(CGContextRef)context;

/**
 *  创建对应类型的涂鸦工具
 *
 *  @param brushType 涂鸦类型
 *
 *  @return 涂鸦工具代理协议
 */
+ (id<PaintBrush>)brushWithType:(BrushType)brushType;

@end
