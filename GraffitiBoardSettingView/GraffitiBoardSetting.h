//
//  GraffitiBoardSetting.h
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,setType) {
    setTypePen,
    setTypeCamera,
    setTypeAlbum,
    setTypeSave,
    setTypeEraser,
    setTypeBack,
    setTyperegeneration,
    setTypeClearAll
};

typedef void(^boardSettingBlock)(setType type);

@interface GraffitiBoardSetting : UIView

- (void)getSettingType:(boardSettingBlock)type;
- (CGFloat)getLineWidth;
- (UIColor *)getLineColor;

@end

//画笔展示的球
@interface ColorBall : UIView

@property (nonatomic, strong) UIColor *ballColor;
@property (nonatomic, assign) CGFloat ballSize;
@property (nonatomic, assign) CGFloat lineWidth;

@end
