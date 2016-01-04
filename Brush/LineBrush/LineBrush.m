//
//  LineBrush.m
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import "LineBrush.h"

@implementation LineBrush

- (void)configureContext:(CGContextRef)context {
    
    [super configureContext:context];
    
    // 直线工具在基类的基础上将 初始点 和 当前点连线即可.
    CGContextMoveToPoint(context, self.startPoint.x, self.startPoint.y);
    CGContextAddLineToPoint(context, self.currentPoint.x, self.currentPoint.y);

}

@end
