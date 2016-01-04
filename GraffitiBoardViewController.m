//
//  GraffitiBoardViewController.m
//  UPOC_Teacher
//
//  Created by Jessica on 16/1/3.
//  Copyright © 2016年 北京新东方教育科技(集团)有限公司. All rights reserved.
//

#import "GraffitiBoardViewController.h"
#import "GraffitiBoardSetting.h"
#import "CustomWindow.h"
#import "JessicaActionSheet.h"
#import "BaseBrush.h"
#import "DrawCommon.h"
#import "PaintingView.h"
#import <ZYQAssetPickerController/ZYQAssetPickerController.h>

@interface GraffitiBoardViewController () <ZYQAssetPickerControllerDelegate,JessicaActionSheetDelegate, UIImagePickerControllerDelegate, GraffitiBoardViewControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) GraffitiBoardSetting *settingBoard;
@property (nonatomic, strong) CustomWindow *drawWindow;

@property (nonatomic, strong) JessicaActionSheet *pencilActionSheet;
@property (nonatomic, strong) JessicaActionSheet *cleanActionSheet;

@property (weak, nonatomic) IBOutlet PaintingView *paintingView;

@end

@implementation GraffitiBoardViewController

#pragma mark - 初始化

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"手绘";
    
    [self addObserver];
    
    [self setupPaintBrush];
    
    [self creatRightBarButtonItem];
    
    [self showSettingBoard];

}

-(void) setupPaintBrush {
    
    self.paintingView.paintBrush = [BaseBrush brushWithType:BrushTypePencil];
    self.paintingView.paintBrush.lineWidth = self.settingBoard.getLineWidth;
    self.paintingView.paintBrush.lineColor = self.settingBoard.getLineColor;
    self.delegate = self;
    
}

//#pragma mark - KVO
//
//- (void)observeValueForKeyPath:(NSString *)keyPath
//                      ofObject:(id)object
//                        change:(NSDictionary *)change
//                       context:(void *)context {
//    
//    if ([keyPath isEqualToString:@"canUndo"]) {
//        
//    }else if ([keyPath isEqualToString:@"canRedo"]) {
//        
//        //        self.redoButton.enabled = self.paintingView.canRedo;
//        
//    }else {
//        
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//        
//    }
//    
//}


- (void)addObserver {
    
    [[NSNotificationCenter defaultCenter] addObserverForName:ImageBoardNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        NSString *str = [note.userInfo objectForKey:@"imageBoardName"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.paintingView.backgroundImage = [UIImage imageNamed:str];
            
        });
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SendColorAndWidthNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.paintingView.paintBrush.lineWidth = self.settingBoard.getLineWidth;
            self.paintingView.paintBrush.lineColor = self.settingBoard.getLineColor;
            
        });
        
        
    }];
    
}

- (void)creatRightBarButtonItem {
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"工具箱" style:UIBarButtonItemStyleBordered target:self action:@selector(rightAction)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)rightAction {
    
    [self showSettingBoard];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (GraffitiBoardSetting *)settingBoard
{
    if (!_settingBoard) {
        
        _settingBoard = [[[NSBundle mainBundle] loadNibNamed:@"GraffitiBoardSetting" owner:nil options:nil] firstObject];
        _settingBoard.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 191);
        
        __weak typeof(self) weakSelf = self;
        
        [_settingBoard getSettingType:^(setType type) {
            
            switch (type) {
                case setTypePen:
                {
                    
                    [weakSelf hideSettingBoard];
                    
                    if (!weakSelf.pencilActionSheet) {
                        
                        weakSelf.pencilActionSheet = [[JessicaActionSheet alloc] initWithTitle:@"画笔类型" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"画笔",@"直线",@"虚线",@"矩形",@"方形",@"椭圆",@"正圆",@"箭头", nil];
                        
                        [weakSelf.pencilActionSheet setTitleColor:[UIColor orangeColor] fontSize:20];
                        
                    }
                    
                    [weakSelf.pencilActionSheet show];
                    
                }
                    break;
                case setTypeCamera:
                {
                    [weakSelf hideSettingBoard];
                    
                    if ([self.delegate respondsToSelector:@selector(drawView:action:)]) {
                        [self.delegate drawView:self action:actionOpenCamera];
                    }
                    
                }
                    break;
                case setTypeAlbum:
                {
                    
//                   [weakSelf hideSettingBoard];
                    
                    if ([self.delegate respondsToSelector:@selector(drawView:action:)]) {
                        [self.delegate drawView:self action:actionOpenAlbum];
                    }
                }
                    break;
                case setTypeSave:
                {
                    [self.paintingView saveToPhotosAlbum];
                    
                }
                    break;
                case setTypeEraser:
                {
                    id<PaintBrush> paintBrush;
                    paintBrush = [BaseBrush brushWithType:BrushTypeEraser];
                    paintBrush.lineWidth = weakSelf.settingBoard.getLineWidth;
                    paintBrush.lineColor = weakSelf.settingBoard.getLineColor;
                    weakSelf.paintingView.paintBrush = paintBrush;
                }
                    break;
                case setTypeBack:
                {
                    
                    if(weakSelf.paintingView.canUndo) {
                        
                        [weakSelf.paintingView undo];
                        
                    }
                
                }
                    break;
                case setTyperegeneration:
                {
                    
                    if(weakSelf.paintingView.canRedo) {
                        
                        [weakSelf.paintingView redo];
                        
                    }
                }
                    break;
                case setTypeClearAll:
                {
                    
                    [weakSelf hideSettingBoard];
                    
                    if (!weakSelf.cleanActionSheet) {
                        
                        weakSelf.cleanActionSheet = [[JessicaActionSheet alloc] initWithTitle:@"清除方式" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"仅清除画笔",@"仅清除背景",@"全部清除", nil];
                        
                        [weakSelf.cleanActionSheet setTitleColor:[UIColor orangeColor] fontSize:20];
                      
                    }
                    
                    [weakSelf.cleanActionSheet show];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }];
        
    }
    
    return _settingBoard;
    
}

#pragma mark - JessicaActionSheet

- (void)actionSheetCancel:(JessicaActionSheet *)actionSheet {
    
    if (actionSheet == self.pencilActionSheet) {
        
    }else if (actionSheet == self.cleanActionSheet) {
        
    }
    
}

- (void)actionSheet:(JessicaActionSheet *)sheet clickedButtonIndex:(NSInteger)buttonIndex {
    
    if (sheet == self.pencilActionSheet) {
        
        id<PaintBrush> paintBrush;
        
        switch (buttonIndex) {
            case 0:
                paintBrush = [BaseBrush brushWithType:BrushTypePencil];
                break;
            case 1:
                paintBrush = [BaseBrush brushWithType:BrushTypeLine];
                break;
            case 2:
                paintBrush = [BaseBrush brushWithType:BrushTypeDashLine];
                break;
            case 3:
                paintBrush = [BaseBrush brushWithType:BrushTypeRectangle];
                break;
            case 4:
                paintBrush = [BaseBrush brushWithType:BrushTypeSquare];
                break;
            case 5:
                paintBrush = [BaseBrush brushWithType:BrushTypeEllipse];
                break;
            case 6:
                paintBrush = [BaseBrush brushWithType:BrushTypeCircle];
                break;
            case 7:
                paintBrush = [BaseBrush brushWithType:BrushTypeArrow];
                break;
            default:
                break;
        }
        
        paintBrush.lineWidth = self.settingBoard.getLineWidth;
        paintBrush.lineColor = self.settingBoard.getLineColor;
        
        self.paintingView.paintBrush = paintBrush;
        
        
    }else if (sheet == self.cleanActionSheet) {
        
        switch (buttonIndex) {
            case 0:
                [self.paintingView clear];
                break;
            case 1:
                self.paintingView.backgroundImage = nil;
                break;
            case 2:
                self.paintingView.backgroundImage = nil;
                [self.paintingView clear];
                break;
            default:
                break;
        }
        
    }
    
}

#pragma mark - SettingBoard

- (CustomWindow *)drawWindow {
    
    if (!_drawWindow) {
        
        _drawWindow = [[CustomWindow alloc] initWithAnimationView:self.settingBoard];
        
    }
    
    return _drawWindow;
    
}

- (void)showSettingBoard {
    
    [self.drawWindow showWithAnimationTime:0.25];
    
}

- (void)hideSettingBoard {
    
    [self.drawWindow hideWithAnimationTime:0.25];
    
}

#pragma mark - Dealloc

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ImageBoardNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SendColorAndWidthNotification object:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.paintingView setBackgroundImage:image];
    
    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        [weakSelf.paintingView setBackgroundImage:image];;
    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        [weakSelf showSettingBoard];
    }];
}

#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    NSMutableArray *marray = [NSMutableArray array];
    
    for(int i=0;i<assets.count;i++){
        
        ALAsset *asset = assets[i];
        
        UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        
        [marray addObject:image];
        
        
    }
    
    [self.paintingView setBackgroundImage:[marray firstObject]];

}

#pragma mark - HBDrawViewDelegate

-(void)drawView:(GraffitiBoardViewController *)graffitiBoardVC action:(actionOpen)action {
    
    switch (action) {
        case actionOpenAlbum:
        {
            ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc]init];
            picker.maximumNumberOfSelection = 1;
            picker.assetsFilter = [ALAssetsFilter allAssets];
            picker.showEmptyGroups = NO;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
            
            break;
        case actionOpenCamera:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                UIImagePickerController *pickVc = [[UIImagePickerController alloc] init];
                
                pickVc.sourceType = UIImagePickerControllerSourceTypeCamera;
                pickVc.delegate = self;
                [self presentViewController:pickVc animated:YES completion:nil];
                
            }else{
                
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alter show];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
