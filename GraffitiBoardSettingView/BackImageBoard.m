//
//  BackImageBoard.m
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import "BackImageBoard.h"
#import "BackImageBoardCollectionViewCell.h"

@interface BackImageBoard () {
    
    NSIndexPath *_lastIndexPath;
    
}

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSArray *array;

@end

@implementation BackImageBoard

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.array.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BackImageBoardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionImageBoardViewID forIndexPath:indexPath];
    
    cell.imageName = self.array[indexPath.item];
    
    if (indexPath.item == 0 && !_lastIndexPath) {
        
        _lastIndexPath = indexPath;
        
        cell.selectImage.hidden = NO;
        
        cell.layer.borderColor = [UIColor purpleColor].CGColor;
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            [[NSNotificationCenter defaultCenter] postNotificationName:ImageBoardNotification object:nil userInfo:[NSDictionary dictionaryWithObject:cell.imageName forKey:@"imageBoardName"]];
            
        });
        
    }
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_lastIndexPath) {
        
        BackImageBoardCollectionViewCell *cell = (BackImageBoardCollectionViewCell *)[collectionView cellForItemAtIndexPath:_lastIndexPath];
        cell.selectImage.hidden = YES;
        cell.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    
    _lastIndexPath = indexPath;
    
    BackImageBoardCollectionViewCell *cell = (BackImageBoardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selectImage.hidden = NO;
    cell.layer.borderColor = [UIColor purpleColor].CGColor;
    
   dispatch_async(dispatch_get_main_queue(), ^{
       
        [[NSNotificationCenter defaultCenter] postNotificationName:ImageBoardNotification object:nil userInfo:[NSDictionary dictionaryWithObject:cell.imageName forKey:@"imageBoardName"]];
       
   });

}

- (UIImageView *)imageView {
    
    if (!_imageView) {
    
        _imageView = [[UIImageView alloc] init];
    
    }

    return _imageView;

}

- (NSArray *)array {
    
    if (!_array) {
    
        _array = [NSArray arrayWithObjects:@"huaban_1",@"huaban_2",@"huaban_3", nil];

    }
    
    return _array;

}


@end
