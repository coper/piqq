//
//  YsnPickImage.m
//  patientv1.0
//
//  Created by liyongli on 15/7/15.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import "YsnPickImage.h"

@implementation YsnPickImage
{
    
    UIImage     *_originalImage;
    NSString    *_orignalImagePath;
    
    UIImage     *_resultSmallImage;
    NSString    *_resultSmallImagePath;
}


-(void)addSelectWithTarget:(id)target action:(SEL)action
{
    self.selectWithTaget = target;
    self.selectBackImageAction = action;
    
  
    
    //    UIActionSheet* actionSheet = [[UIActionSheet alloc]
    //                                  initWithTitle:@"请选择文件来源"
    //                                  delegate:self
    //                                  cancelButtonTitle:@"取消"
    //                                  destructiveButtonTitle:nil
    //                                  otherButtonTitles:@"照相机",@"本地相簿",nil];
    //    [actionSheet showInView:[self.view window]];
    //
    LXActionSheet *actionSheet = [[LXActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@[@"拍照",@"选择相册"]];
    [actionSheet showInView:[self.view window]];
    
}


- (void)didClickOnButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex = [ %ld ]", (long)buttonIndex);
    switch (buttonIndex)
    {
        case 0://照相机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            //去掉炫光效果
            [imagePicker.navigationBar setTranslucent:NO];
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.selectWithTaget presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 1://本地相簿
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            //去掉炫光效果
            [imagePicker.navigationBar setTranslucent:NO];
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.selectWithTaget presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
            //        case 3://摄像机
            //        {
            //            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            //            imagePicker.delegate = self;
            //            imagePicker.allowsEditing = YES;
            //            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            imagePicker.videoQuality = UIImagePickerControllerQualityTypeLow;
            //            [self.selectWithTaget presentViewController:imagePicker animated:YES completion:nil];
            //        }
            //            break;
            //        case 4://本地视频
            //        {
            //            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            //            imagePicker.delegate = self;
            //            imagePicker.allowsEditing = YES;
            //            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            [self.selectWithTaget presentViewController:imagePicker animated:YES completion:nil];
            //        }
            //            break;
        default:
            break;
    }
}


#pragma UIActionSheetDelegate Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex = [ %ld ]", (long)buttonIndex);
    switch (buttonIndex)
    {
        case 0://照相机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.selectWithTaget presentViewController:imagePicker animated:YES completion:nil];
           
        }
            break;
        case 1://本地相簿
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
           
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self.selectWithTaget presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
            //        case 3://摄像机
            //        {
            //            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            //            imagePicker.delegate = self;
            //            imagePicker.allowsEditing = YES;
            //            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            imagePicker.videoQuality = UIImagePickerControllerQualityTypeLow;
            //            [self.selectWithTaget presentViewController:imagePicker animated:YES completion:nil];
            //        }
            //            break;
            //        case 4://本地视频
            //        {
            //            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            //            imagePicker.delegate = self;
            //            imagePicker.allowsEditing = YES;
            //            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            [self.selectWithTaget presentViewController:imagePicker animated:YES completion:nil];
            //        }
            //            break;
        default:
            break;
    }
}

#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"imagePickerController  info  ->>%@ ",info);
    
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage])
    {
        //选中的原始图片
        _originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        NSLog(@"截取大图的宽度  tempWidth  ->>%f", _originalImage.size.width);
        NSLog(@"截取大图的高度  tempHeight ->>%f", _originalImage.size.height);
        
        [self performSelector:@selector(callBack) withObject:nil afterDelay:0.5];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  处理选中的图片
 *  @param imageView 将图像显示在这里
 *          nil:     默认生成的大小： 93*93
 */
-(BOOL)makeAndSaveImage:(UIImageView *)imageimageView
{
    BOOL isOk = false;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
    isOk = [fileManager fileExistsAtPath:imageFilePath];
    if(isOk)
    {
        isOk = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    int tempWidth  = 93;
    int tempHeight = 93;
    if (imageimageView)
    {
        tempWidth  = imageimageView.frame.size.width*3;
        tempHeight = imageimageView.frame.size.height*3;
    }
    NSLog(@"生成小图的宽度  tempWidth  ->>%d", tempWidth);
    NSLog(@"生成小图的高度  tempHeight ->>%d", tempHeight);
    //制作成小图，默认是 93*93
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:_originalImage size:CGSizeMake(tempWidth, tempHeight)];
    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];   //写入文件
    NSLog(@"小图生成的路径  imageFile ->>  %@", imageFilePath);
    //读取图片文件的路径
    _resultSmallImagePath = imageFilePath;
    //读取图片文件
    _resultSmallImage     = [UIImage imageWithContentsOfFile:imageFilePath];
    //显示在 ImageView上面
    if (imageimageView)
    {
        [self setImageView:imageimageView];
    }
    return isOk;
}

/**
 *  将图像显示到指定的ImageView中
 *  @param imageView 指定的imageView
 */
-(void)setImageView:(UIImageView *) imageView
{
    imageView.image = _resultSmallImage;
    [imageView.layer setCornerRadius:CGRectGetHeight([imageView bounds])/2];  //修改半径，实现头像的圆形化
    imageView.layer.masksToBounds = YES;
}


//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image)
    {
        newimage = nil;
    }
    else
    {
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height)
        {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

//回调给调用函数
- (void)callBack
{
    //回调
    if ([self.selectWithTaget respondsToSelector:self.selectBackImageAction])
    {
        msgSend(msgTarget(self.selectWithTaget), self.selectBackImageAction, self);
    }
}

#pragma 返回数据
/**
 *  返回处理好的图像
 */
-(UIImage *)getSmallResultImage
{
    return _resultSmallImage;
}

/**
 *  返回处理好的图像的路径
 */
-(NSString *)getSmallImagePath
{
    return _resultSmallImagePath;
}

/**
 *  返回原始的图像
 */
-(UIImage *)getOrignalResultImage
{
    return _originalImage;
}

/**
 *  返回原始的图像的路径
 */
-(NSString *)getOrignalImagePath
{
    BOOL isOk;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"bigPhoto.jpg"];
    isOk = [fileManager fileExistsAtPath:imageFilePath];
    if(isOk)
    {
        isOk = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    [UIImageJPEGRepresentation(_originalImage, 1.0f) writeToFile:imageFilePath atomically:YES];   //写入文件
    _orignalImagePath = imageFilePath;
    NSLog(@"大图的生成路径  ->>  %@", _orignalImagePath);
    return _orignalImagePath;
}
@end
