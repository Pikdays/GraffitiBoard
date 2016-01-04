//
//  BaseBrush.m
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import "BaseBrush.h"
#import "LineBrush.h"
#import "ArrowBrush.h"
#import "PencilBrush.h"
#import "EraserBrush.h"
#import "CircleBrush.h"
#import "SquareBrush.h"
#import "EllipseBrush.h"
#import "DashLineBrush.h"
#import "RectangleBrush.h"

@interface BaseBrush ()

/**
 *  是否需要绘制
 */
@property (nonatomic, readwrite) BOOL needsDraw;

/**
 *  初始点
 */
@property (nonatomic, readwrite) CGPoint startPoint;

/**
 *  上一点
 */
@property (nonatomic, readwrite) CGPoint previousPoint;

/**
 *  当前点
 */
@property (nonatomic, readwrite) CGPoint currentPoint;

@end

@implementation BaseBrush
@synthesize lineWidth = _lineWidth, lineColor = _lineColor;

+ (id<PaintBrush>)brushWithType:(BrushType)brushType {
    
    switch (brushType) {
        case BrushTypePencil:
            return [PencilBrush new];
            
        case BrushTypeEraser:
            return [EraserBrush new];
            
        case BrushTypeLine:
            return [LineBrush new];
            
        case BrushTypeDashLine:
            return [DashLineBrush new];
            
        case BrushTypeRectangle:
            return [RectangleBrush new];
            
        case BrushTypeSquare:
            return [SquareBrush new];
            
        case BrushTypeEllipse:
            return [EllipseBrush new];
            
        case BrushTypeCircle:
            return [CircleBrush new];
            
        case BrushTypeArrow:
            return [ArrowBrush new];
    }
    
    return nil;
    
}

#pragma mark - PaintBrush 协议方法

- (void)beginAtPoint:(CGPoint)point {
    
    self.startPoint    = point;
    self.currentPoint  = point;
    self.previousPoint = point;
    self.needsDraw     = YES;
    
}

- (void)moveToPoint:(CGPoint)point {
    
    self.previousPoint = self.currentPoint;
    self.currentPoint  = point;
    
}

- (void)end {
    
    self.needsDraw = NO;
    
}

- (void)drawInContext:(CGContextRef)context {
    
    [self configureContext:context];
    
    CGContextStrokePath(context);
    
}

- (CGRect)redrawRect {
    
    // 根据 起点, 上一点, 当前点 三点计算包含三点的最小重绘矩形.适用于画矩形,椭圆之类的图案.
    CGFloat minX = fmin(fmin(self.startPoint.x, self.previousPoint.x), self.currentPoint.x) - self.lineWidth / 2;
    CGFloat minY = fmin(fmin(self.startPoint.y, self.previousPoint.y), self.currentPoint.y) - self.lineWidth / 2;
    CGFloat maxX = fmax(fmax(self.startPoint.x, self.previousPoint.x), self.currentPoint.x) + self.lineWidth / 2;
    CGFloat maxY = fmax(fmax(self.startPoint.y, self.previousPoint.y), self.currentPoint.y) + self.lineWidth / 2;
    
    return CGRectMake(minX, minY, maxX - minX, maxY - minY);

}

#pragma mark - 配置上下文

- (void)configureContext:(CGContextRef)context {
    
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);

}

@end
