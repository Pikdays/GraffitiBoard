//
//  BackImageBoardCollectionViewCell.m
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import "BackImageBoardCollectionViewCell.h"

@interface BackImageBoardCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@end

@implementation BackImageBoardCollectionViewCell

- (void)awakeFromNib {
    
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.masksToBounds = YES;
    self.selectImage.hidden = YES;
    
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    self.backImage.image = [UIImage imageNamed:imageName];
    
}

@end
