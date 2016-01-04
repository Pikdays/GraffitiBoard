//
//  PencilBrush.m
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import "PencilBrush.h"

@interface PencilBrush () {

    /**
     *  绘图路径
     */
    CGMutablePathRef _path;
    
}

/**
 *  上次触摸结束点
 */
@property (nonatomic) CGPoint previousPoint;

/**
 *  当前中间点,即上次触摸结束点和当前触摸点的中点
 */
@property (nonatomic) CGPoint currentMiddlePoint;

/**
 *  上次中间点
 */
@property (nonatomic) CGPoint previousMiddlePoint;

/**
 *  是否需要绘制
 */
@property (nonatomic) BOOL needsDraw;

@end

@implementation PencilBrush

// 普通画笔相对基类有些特殊,这里重写了几个属性,初始点干脆用不到.
// needsDraw 需要根据两次移动间距决定,相应的 previousPoint 也并不是每次移动都一定刷新值.
@synthesize previousPoint = _previousPoint;
@synthesize needsDraw     = _needsDraw;

#pragma mark - Dealloc

- (void)dealloc {
    
    if (_path) {
    
        CGPathRelease(_path);
    
    }
    
}

#pragma mark - PaintBrush 协议方法

- (void)beginAtPoint:(CGPoint)point {
    
    self.needsDraw           = YES;
    self.previousPoint       = point;
    self.previousMiddlePoint = point;
    self.currentMiddlePoint  = point;
    
    // 普通画笔比较特殊,要保证之前的每一个移动点都在,因此需要一条路径.
    if (_path) {
        
        CGPathRelease(_path);
    
    }
    _path = CGPathCreateMutable();
    
    CGPathMoveToPoint   (_path, NULL, point.x, point.y);
    // 为了点下去就能画一个点.
    CGPathAddLineToPoint(_path, NULL, point.x, point.y);
    
}

- (void)moveToPoint:(CGPoint)point {
    
    // 移动距离小于笔画宽度一半,基本看不出来,没必要重绘.
    CGFloat dx = point.x - self.currentPoint.x;
    CGFloat dy = point.y - self.currentPoint.y;
    if ( (dx * dx + dy * dy) < (self.lineWidth * self.lineWidth / 4) ) {
        
        self.needsDraw = NO;
        return;
        
    }
    self.needsDraw = YES;
    
    self.previousMiddlePoint = self.currentMiddlePoint;
    self.currentMiddlePoint  = CGPointMake((self.previousPoint.x + point.x) / 2,
                                           (self.previousPoint.y + point.y) / 2);
    
    // 用当前中间点作为曲线终点,上次触摸结束点作为曲线控制点,能获得更平滑的线条.
    CGPathAddQuadCurveToPoint(_path, NULL,
                              self.previousPoint.x, self.previousPoint.y,
                              self.currentMiddlePoint.x, self.currentMiddlePoint.y);
    
    self.previousPoint = point;
    
}

- (void)end {
    
    if (_path) {
        
        CGPathRelease(_path);
        _path = NULL;
    
    }
    
    self.needsDraw = NO;

}

- (CGRect)redrawRect {
    
    // 根据曲线起点,控制点,终点计算最小重绘范围.
    CGFloat minX = fmin(fmin(self.currentMiddlePoint.x, self.previousMiddlePoint.x), self.previousPoint.x) - self.lineWidth / 2;
    CGFloat minY = fmin(fmin(self.currentMiddlePoint.y, self.previousMiddlePoint.y), self.previousPoint.y) - self.lineWidth / 2;
    CGFloat maxX = fmax(fmax(self.currentMiddlePoint.x, self.previousMiddlePoint.x), self.previousPoint.x) + self.lineWidth / 2;
    CGFloat maxY = fmax(fmax(self.currentMiddlePoint.y, self.previousMiddlePoint.y), self.previousPoint.y) + self.lineWidth / 2;
    
    return CGRectMake(minX, minY, maxX - minX, maxY - minY);
    
}

#pragma mark - 父类方法

- (void)configureContext:(CGContextRef)context {
    
    [super configureContext:context];
    
    // 普通画笔工具在基类的基础上添加自己自定义的路径即可.
    CGContextAddPath(context, _path);
    
}

@end
