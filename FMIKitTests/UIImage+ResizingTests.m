//
//  UIImage+ResizingTests.m
//
//  Created by Florian Mielke on 07.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "UIImage+Resizing.h"


@interface UIImage_ResizeTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) UIImage *testImageLandscape;
@property (NS_NONATOMIC_IOSONLY) UIImage *testImagePortraitSmallWidth;
@property (NS_NONATOMIC_IOSONLY) UIImage *testImageBig;

@end



@implementation UIImage_ResizeTests


#pragma mark -
#pragma mark Fixture

- (void)setUp
{
    [super setUp];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *pathToTestImageLandscape = [bundle pathForResource:@"TestImageLandscape" ofType:@"png"];
    _testImageLandscape = [UIImage imageWithContentsOfFile:pathToTestImageLandscape];
    
    NSString *pathToTestImagePortraitSmallWidth = [bundle pathForResource:@"TestImagePortraitSmallWidth" ofType:@"jpg"];
    _testImagePortraitSmallWidth = [UIImage imageWithContentsOfFile:pathToTestImagePortraitSmallWidth];

    NSString *pathToTestImageBig = [bundle pathForResource:@"TestImageBig" ofType:@"jpeg"];
    _testImageBig = [UIImage imageWithContentsOfFile:pathToTestImageBig];
}


- (void)tearDown
{
    [self setTestImageLandscape:nil];
    [self setTestImagePortraitSmallWidth:nil];
    [self setTestImageBig:nil];
    
    [super tearDown];
}



#pragma mark -
#pragma mark Scaling

- (void)testLandscapeImageIsScaledToSmallerLandscapeSizeProportionately
{
    CGSize aspectedSize = CGSizeMake(800.0, 600.0);
    UIImage *scaledImage = [[self testImageLandscape] scaledImageToFitSize:aspectedSize];
    
    XCTAssertEqual(scaledImage.size.width, (CGFloat)750.0);
    XCTAssertEqual(scaledImage.size.height, aspectedSize.height);
}


- (void)testLandscapeImageIsScaledToSmallerPortraitSizeProportionately
{
    CGSize aspectedSize = CGSizeMake(600.0, 800.0);
    UIImage *scaledImage = [[self testImageLandscape] scaledImageToFitSize:aspectedSize];
    
    XCTAssertEqual(scaledImage.size.width, aspectedSize.width);
    XCTAssertEqual(scaledImage.size.height, (CGFloat)480.0);
}


- (void)testLandscapeImageIsScaledToSquaredSizeProportionately
{
    CGSize aspectedSize = CGSizeMake(800.0, 800.0);
    UIImage *scaledImage = [[self testImageLandscape] scaledImageToFitSize:aspectedSize];
    
    XCTAssertEqual(scaledImage.size.width, aspectedSize.width);
    XCTAssertEqual(scaledImage.size.height, (CGFloat)640.0);
}


- (void)testBigImageIsBiggerToLandscapeSizeProportionately
{
    CGSize aspectedSize = CGSizeMake(595.0, 842.0);
    UIImage *scaledImage = [[self testImageBig] scaledImageToFitSize:aspectedSize];
    
    XCTAssertEqual(scaledImage.size.width, aspectedSize.width);
    XCTAssertEqual(scaledImage.size.height, (CGFloat)793.0);
}


- (void)testPortraitImageSmallWidthIsScaledToSmallerPortraitSizeProportionately
{
    CGSize aspectedSize = CGSizeMake(600.0, 800.0);
    UIImage *scaledImage = [[self testImagePortraitSmallWidth] scaledImageToFitSize:aspectedSize];
    
    XCTAssertEqual(scaledImage.size.width, (CGFloat)360.0);
    XCTAssertEqual(scaledImage.size.height, aspectedSize.height);
}


@end
