//
//  RectangleBrush.m
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import "RectangleBrush.h"

@implementation RectangleBrush

- (void)drawInContext:(CGContextRef)context {
    
    [self configureContext:context];
    
    // 这里选择重写此方法自己画,因为在 configureContext 中添加路径的话会影响子类.
    CGContextStrokeRect(context, self.rectToDraw);

}

- (CGRect)rectToDraw {
    
    return (CGRect) {
        
        MIN(self.startPoint.x,  self.currentPoint.x),
        MIN(self.startPoint.y,  self.currentPoint.y),
        ABS(self.startPoint.x - self.currentPoint.x),
        ABS(self.startPoint.y - self.currentPoint.y),
    
    };
    
}

@end
