//
//  UILabel+StateHandlingTests.m
//
//  Created by Florian Mielke on 18.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "UILabel+StateHandling.h"
#import "UIColor+SystemDefaults.h"


@interface UILabel_StateHandlingTests : XCTestCase

@property (nonatomic, strong) UILabel *sut;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) NSDictionary *defaultAttributes;

@end



@implementation UILabel_StateHandlingTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];

    self.textColor = [UIColor cellDefaultStyleDetailLabelColor];
    self.tintColor = [UIColor blueColor];
    
    self.sut = [[UILabel alloc] init];
    self.sut.text = @"Lorem ipsum";
    self.sut.textColor = self.textColor;
    self.sut.tintColor = self.tintColor;
    
    self.defaultAttributes = [self.sut.attributedText attributesAtIndex:0 effectiveRange:NULL];
}


- (void)tearDown
{
    self.sut = nil;
    self.textColor = nil;
    self.tintColor = nil;
    self.defaultAttributes = nil;
    
    [super tearDown];
}



#pragma mark - Tests

- (void)testLabelShouldBeInitialized
{
    XCTAssertNotNil(self.sut);
}


- (void)testLabelShouldBeConfigured
{
    XCTAssertEqualObjects(self.sut.text, @"Lorem ipsum");
    XCTAssertTrue(CGColorEqualToColor(self.sut.textColor.CGColor, self.textColor.CGColor));
    XCTAssertTrue(CGColorEqualToColor(self.sut.tintColor.CGColor, self.tintColor.CGColor));
}


- (void)testLabelShouldUseTintColorWhenMarkAsActive
{
    // When
    [self.sut fm_markAsActive:YES];
    
    // Then
    XCTAssertTrue(CGColorEqualToColor(self.sut.textColor.CGColor, self.tintColor.CGColor));
}


- (void)testLabelShouldUseTextColorWhenResetColoringActive
{
    // Given
    [self.sut fm_markAsActive:YES];
    
    // When
    [self.sut fm_markAsActive:NO];
    
    // Then
    XCTAssertTrue(CGColorEqualToColor(self.sut.textColor.CGColor, self.textColor.CGColor));
}


- (void)testLabelShouldStrikethroughTextWhenMarkingAsInvalid
{
    // Given
    NSMutableDictionary *invalidAttributes = [self.defaultAttributes mutableCopy];
    [invalidAttributes setValue:@(NSUnderlineStyleSingle) forKey:NSStrikethroughStyleAttributeName];
    
    // When
    [self.sut fm_markAsValid:NO];
    
    // Then
    NSDictionary *attributes = [self.sut.attributedText attributesAtIndex:0 effectiveRange:NULL];
    XCTAssertTrue([attributes isEqualToDictionary:[invalidAttributes copy]]);
}


- (void)testLabelShouldRemoveStrikethroughTextWhenRemarkingAsValid
{
    // Given
    NSMutableDictionary *invalidAttributes = [self.defaultAttributes mutableCopy];
    [invalidAttributes setValue:self.textColor forKey:NSForegroundColorAttributeName];
 
    [self.sut fm_markAsValid:NO];
    
    // When
    [self.sut fm_markAsValid:YES];
    
    // Then
    NSDictionary *attributes = [self.sut.attributedText attributesAtIndex:0 effectiveRange:NULL];
    XCTAssertTrue([attributes isEqualToDictionary:[invalidAttributes copy]]);
}


- (void)testLabelShouldStrikethroughTextWhenMarkingActiveAsValid
{
    // Given
    NSMutableDictionary *invalidAttributes = [self.defaultAttributes mutableCopy];
    [invalidAttributes setValue:@(NSUnderlineStyleSingle) forKey:NSStrikethroughStyleAttributeName];
    [invalidAttributes setValue:self.tintColor forKey:NSForegroundColorAttributeName];
    
    [self.sut fm_markAsActive:YES];
    
    // When
    [self.sut fm_markAsValid:NO];
    
    // Then
    NSDictionary *attributes = [self.sut.attributedText attributesAtIndex:0 effectiveRange:NULL];
    XCTAssertTrue([attributes isEqualToDictionary:[invalidAttributes copy]]);
}


- (void)testLabelShouldUpdateAttributedTextWhenUsingHelperMethod
{
    // Given
    NSDictionary *attributes = [self.sut.attributedText attributesAtIndex:0 effectiveRange:NULL];
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:@"Hello" attributes:attributes];
    
    // When
    [self.sut fm_setAttributedText:@"Hello"];
    
    // Then
    XCTAssertEqualObjects(self.sut.attributedText, attributedText);
}




@end
