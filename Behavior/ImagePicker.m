//
//  ImagePicker.m
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import "ImagePicker.h"

@interface ImagePicker () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/**
 *  关联的视图控制器
 */
@property (nonatomic, weak) IBOutlet UIViewController *viewController;

/**
 *  选中的图片
 */
@property (nonatomic, readwrite, strong) UIImage *selectedImage;

@end

@implementation ImagePicker

- (IBAction)pickImageAction:(UIBarButtonItem *)sender {
    
    UIImagePickerController *pickerVC = [UIImagePickerController new];
    
    pickerVC.delegate   = self;
    pickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    pickerVC.modalPresentationStyle = UIModalPresentationPopover;
    pickerVC.popoverPresentationController.barButtonItem = sender;
    
    [self.viewController presentViewController:pickerVC animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.selectedImage = info[UIImagePickerControllerOriginalImage];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    [self.viewController dismissViewControllerAnimated:YES completion:nil];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.viewController dismissViewControllerAnimated:YES completion:nil];

}

@end
