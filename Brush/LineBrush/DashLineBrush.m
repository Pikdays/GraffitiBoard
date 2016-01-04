//
//  DashLineBrush.m
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import "DashLineBrush.h"

@implementation DashLineBrush

- (void)configureContext:(CGContextRef)context {
    
    [super configureContext:context];
    
    // 虚线在父类直线的基础上设置虚线性质即可.
    CGFloat lengths[2] = { self.lineWidth, self.lineWidth * 2 };
    CGContextSetLineDash(context, 0, lengths, 2);
    
}

@end
