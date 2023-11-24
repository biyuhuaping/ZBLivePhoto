//
//  ZBLivePhotoTool.h
//  LivePhoto
//
//  Created by ZB on 2023/11/19.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBLivePhotoTool : NSObject

+ (instancetype)shareTool;

/// 剪切视频
- (AVAsset *)cutVideoWithPath:(NSString *)videoPath startTime:(NSTimeInterval)start endTime:(NSTimeInterval)end;

/// 视频合成Img
- (void)generatorOriginImgWithPath:(NSString *)videoPath seconds:(NSTimeInterval)seconds imageName:(NSString *)imgName handleImg:(void(^)(UIImage *originImage,NSString *imagePath,NSError *error))handle;

/// 视频合成LivePhoto
- (void)generatorLivePhotoWithPath:(NSString *)videoPath newPath:(NSString *)videoPath originImgPath:(NSString *)originImgPath livePhotoImgPath:(NSString *)imgPath handleLivePhoto:(void(^)(PHLivePhoto *livePhoto))handle;

/// 使用视频路径保存LivePhoto
- (void)saveLivePhotoWithVideoPath:(NSString *)videoPath imagePath:(NSString *)imagePath handle:(void(^)(BOOL,NSError *))saveHandle;

@end

NS_ASSUME_NONNULL_END
