//
//  Created by Florian Mielke on 27.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIImagePickerController.h"
#import "FMIKitPrivates.h"


typedef struct {
	NSInteger delete;
	NSInteger library;
	NSInteger camera;
	NSInteger cancel;
} FMImageButtonIndexes;



@interface FMIImagePickerController ()

@property (nonatomic, assign) FMImageButtonIndexes imageButtonIndexes;

@end



@implementation FMIImagePickerController

@dynamic delegate;

#pragma mark -
#pragma mark Action sheet

- (UIActionSheet *)actionSheetForImage:(UIImage *)image
{
    [self updateActionSheetButtonIndexesForImage:image];
    
    return ([self isCameraAvailable]) ? [self actionSheetWithCameraButtonForImage:image] : [self actionSheetAbsentCameraButtonForImage:image];
}


- (UIActionSheet *)actionSheetWithCameraButtonForImage:(UIImage *)image
{
    return [[UIActionSheet alloc] initWithTitle:nil
                                       delegate:self
                              cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"Cancel", @"FMIKitLocalizable", [FMIKitPrivates resourcesBundle], @"Used for button title")
                         destructiveButtonTitle:[self destructiveButtonTitleForImage:image]
                              otherButtonTitles:NSLocalizedStringFromTableInBundle(@"Choose Photo", @"FMIKitLocalizable", [FMIKitPrivates resourcesBundle], @"Used for button title: Choose an existing photo")
                                                , NSLocalizedStringFromTableInBundle(@"Take Photo", @"FMIKitLocalizable", [FMIKitPrivates resourcesBundle], @"Used for button title: Take a new photo"), nil];
}


- (UIActionSheet *)actionSheetAbsentCameraButtonForImage:(UIImage *)image
{
    return [[UIActionSheet alloc] initWithTitle:nil
                                       delegate:self
                              cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"Cancel", @"FMIKitLocalizable", [FMIKitPrivates resourcesBundle], @"Used for button title")
                         destructiveButtonTitle:[self destructiveButtonTitleForImage:image]
                              otherButtonTitles:NSLocalizedStringFromTableInBundle(@"Choose Photo", @"FMIKitLocalizable", [FMIKitPrivates resourcesBundle], @"Used for button title: Choose an existing photo"), nil];
}


- (void)updateActionSheetButtonIndexesForImage:(UIImage *)image
{
    FMImageButtonIndexes imageButtonIndexes;
    NSInteger index = 0;
    
    if (image != nil)
    {
        imageButtonIndexes.delete = index;
        index++;
    }
    else
    {
        imageButtonIndexes.delete = NSIntegerMax;
    }
    
    imageButtonIndexes.library = index;
    index++;
    
    if ([self isCameraAvailable])
    {
        imageButtonIndexes.camera = index;
        index++;
    }
    else
    {
        imageButtonIndexes.camera = NSIntegerMax;
    }
    
    imageButtonIndexes.cancel = index;
    [self setImageButtonIndexes:imageButtonIndexes];
}


- (BOOL)isCameraAvailable
{
    return ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]);
}


- (NSString *)destructiveButtonTitleForImage:(UIImage *)image
{
    return ((image == nil) ? nil : NSLocalizedStringFromTableInBundle(@"Delete Photo", @"FMIKitLocalizable", [FMIKitPrivates resourcesBundle], @"Used for button title: Delete current photo"));
}



#pragma mark -
#pragma mark Action sheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    FMImageButtonIndexes imageButtonIndexes = [self imageButtonIndexes];

	if (buttonIndex == imageButtonIndexes.delete)
	{
		[[self delegate] imagePickerControllerDidChooseDelete:self];
	}
	else if (buttonIndex == imageButtonIndexes.library)
	{
		[[self delegate] imagePickerControllerDidChooseLibrary:self];
	}
	else if (buttonIndex == imageButtonIndexes.camera)
	{
		[[self delegate] imagePickerControllerDidChooseCamera:self];
	}
	else
	{
        [[self delegate] imagePickerControllerDidChooseCancel:self];
	}
}


@end
