//
//  EllipseBrush.m
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import "EllipseBrush.h"

@implementation EllipseBrush

- (void)drawInContext:(CGContextRef)context {
    
    [self configureContext:context];
    
    CGContextStrokeEllipseInRect(context, self.rectToDraw);
    
}

@end
