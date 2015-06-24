//
//  FMIImagePickerController.h
//
//  Created by Florian Mielke on 27.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMIImagePickerController;


@protocol FMIImagePickerControllerDelegate <NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (void)imagePickerControllerDidChooseCamera:(FMIImagePickerController *)controller;

- (void)imagePickerControllerDidChooseDelete:(FMIImagePickerController *)controller;

- (void)imagePickerControllerDidChooseLibrary:(FMIImagePickerController *)controller;

- (void)imagePickerControllerDidChooseCancel:(FMIImagePickerController *)controller;

@end


@interface FMIImagePickerController : UIImagePickerController <UIActionSheetDelegate>

@property (weak, NS_NONATOMIC_IOSONLY) id <FMIImagePickerControllerDelegate> delegate;

- (UIActionSheet *)actionSheetForImage:(UIImage *)image;

@end


