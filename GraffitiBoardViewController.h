//
//  GraffitiBoardViewController.h
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GraffitiBoardViewController;

typedef NS_ENUM(NSInteger, actionOpen) {
    actionOpenAlbum,
    actionOpenCamera
};

@protocol GraffitiBoardViewControllerDelegate <NSObject>

- (void)drawView:(GraffitiBoardViewController *)graffitiBoardVC action:(actionOpen)action;

@end

@interface GraffitiBoardViewController : UIViewController

@property (nonatomic, weak) id<GraffitiBoardViewControllerDelegate>  delegate;

@end
