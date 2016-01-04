//
//  ImagePicker.h
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePicker : UIControl

/**
 *  选中的图片
 */
@property (nonatomic, readonly, strong) UIImage *selectedImage;

@end
