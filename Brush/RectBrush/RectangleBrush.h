//
//  RectangleBrush.h
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import "BaseBrush.h"

@interface RectangleBrush : BaseBrush

/**
 *  获取用于椭圆/矩形绘制的矩形范围
 */
@property (nonatomic, readonly) CGRect rectToDraw;

@end
