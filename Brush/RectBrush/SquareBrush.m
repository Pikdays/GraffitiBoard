//
//  SquareBrush.m
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import "SquareBrush.h"

@implementation SquareBrush

- (void)drawInContext:(CGContextRef)context {
    
    [self configureContext:context];
    
    // 由于继承自圆类,原点会自动调整的,直接画矩形即可.
    CGContextStrokeRect(context, self.rectToDraw);

}

@end
