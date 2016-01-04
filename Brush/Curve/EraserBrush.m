//
//  EraserBrush.m
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import "EraserBrush.h"

@implementation EraserBrush

- (void)configureContext:(CGContextRef)context {
    
    [super configureContext:context];
    
    // 橡皮只要在父类普通画笔的基础上将混合模式由默认的 normal 改为 clear 即可.
    CGContextSetBlendMode(context, kCGBlendModeClear);
    
}

@end
