//
//  FMIImagePickerController.h
//
//  Created by Florian Mielke on 27.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import UIKit;

@class FMIImagePickerController;


@protocol FMIImagePickerControllerDelegate <NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (void)imagePickerControllerDidChooseCamera:(FMIImagePickerController *)controller;

- (void)imagePickerControllerDidChooseDelete:(FMIImagePickerController *)controller;

- (void)imagePickerControllerDidChooseLibrary:(FMIImagePickerController *)controller;

- (void)imagePickerControllerDidChooseCancel:(FMIImagePickerController *)controller;

@end


@interface FMIImagePickerController : UIImagePickerController <UIActionSheetDelegate>

@property (nonatomic, weak) id <FMIImagePickerControllerDelegate> delegate;

- (UIActionSheet *)actionSheetForImage:(UIImage *)image;

@end


