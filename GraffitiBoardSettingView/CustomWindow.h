//
//  CustomWindow.h
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomWindow : UIWindow

@property (nonatomic, assign) NSTimeInterval animationTime;

- (instancetype)initWithAnimationView:(UIView *)animationView;

- (void)showWithAnimationTime:(NSTimeInterval)second;

- (void)hideWithAnimationTime:(NSTimeInterval)second;

@end
