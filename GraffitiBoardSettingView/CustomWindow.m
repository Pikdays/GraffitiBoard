//
//  CustomWindow.m
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import "CustomWindow.h"

@interface CustomWindow()

@property (nonatomic, weak) UIView *animationView;

@end

@implementation CustomWindow

- (instancetype)initWithAnimationView:(UIView *)animationView {
    
    if (self = [super initWithFrame:[[UIScreen mainScreen] bounds]]) {
        
        self.windowLevel = UIWindowLevelAlert;
        
        self.animationView = animationView;
        
        [self addSubview:self.animationView];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:@"hideTopWindow" object:nil queue:nil usingBlock:^(NSNotification *note) {
            
            [self hideWithAnimationTime:self.animationTime];
            
        }];
        
    }
    
    return self;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    
    if (!CGRectContainsPoint(self.animationView.frame, touchPoint))
        [self hideWithAnimationTime:self.animationTime];
    
}

- (void)showWithAnimationTime:(NSTimeInterval)second {
    
    self.animationTime  = second;
    
    [self makeKeyAndVisible];
    
    [UIView animateWithDuration:self.animationTime delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.animationView.transform = CGAffineTransformMakeTranslation(0, -self.animationView.bounds.size.height);
            
        }];
        
        
    } completion:^(BOOL finished) {
        
        
        self.hidden = NO;
        
    }];
    
}

- (void)hideWithAnimationTime:(NSTimeInterval)second {
    
    self.animationTime  = second;
    
    [UIView animateWithDuration:self.animationTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.animationView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            self.hidden = YES;
            
        }];
        
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark - delloc

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideTopWindow" object:nil];
    
}

@end
