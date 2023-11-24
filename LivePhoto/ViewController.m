//
//  ViewController.m
//  LivePhoto
//
//  Created by ZB on 2023/11/19.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZBLivePhotoTool.h"

@interface ViewController ()


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 60, 140, 50);
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:@"视频转livePhoto" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(laodAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 120, 140, 50);
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn2 setTitle:@"保存livePhoto到相" forState:UIControlStateNormal];
    [btn2 setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}


- (void)laodAction{
    PHLivePhotoView *photoView = [[PHLivePhotoView alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 300)];
    photoView.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:photoView];
    
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"111" ofType:@"MOV"];
    [[ZBLivePhotoTool shareTool] generatorOriginImgWithPath:videoPath seconds:2.0 imageName:@"image" handleImg:^(UIImage *originImage, NSString *imagePath, NSError *error) {
        NSString *outPut = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true).firstObject;
        NSString *newImgPath = [outPut stringByAppendingPathComponent:@"IMG.JPG"];
        NSString *newVideoPath = [outPut stringByAppendingPathComponent:@"IMG.MOV"];
        [[NSFileManager defaultManager] removeItemAtPath:newImgPath error:nil];
        [[NSFileManager defaultManager] removeItemAtPath:newVideoPath error:nil];
        
        [[ZBLivePhotoTool shareTool] generatorLivePhotoWithPath:videoPath newPath:newVideoPath originImgPath:imagePath livePhotoImgPath:newImgPath handleLivePhoto:^(PHLivePhoto *livePhoto) {
            photoView.livePhoto = livePhoto;
            [[ZBLivePhotoTool shareTool] saveLivePhotoWithVideoPath:newVideoPath imagePath:newImgPath handle:^(BOOL success, NSError *error) {

            }];
        }];
    }];
}

- (void)saveAction{
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
