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

@property (NS_NONATOMIC_IOSONLY) UILabel *sut;
@property (NS_NONATOMIC_IOSONLY) UIColor *textColor;
@property (NS_NONATOMIC_IOSONLY) UIColor *tintColor;
@property (NS_NONATOMIC_IOSONLY) NSDictionary *defaultAttributes;

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
    
    XCTAssertTrue(CGColorEqualToColor(self.sut.textColor.CGColor, self.tintColor.CGColor));
}


- (void)testLabelShouldUseTextColorWhenResetColoringActive
{

    [self.sut fm_markAsActive:YES];
    
    [self.sut fm_markAsActive:NO];
    
    XCTAssertTrue(CGColorEqualToColor(self.sut.textColor.CGColor, self.textColor.CGColor));
}


- (void)testLabelShouldStrikethroughTextWhenMarkingAsInvalid
{

    NSMutableDictionary *invalidAttributes = [self.defaultAttributes mutableCopy];
    [invalidAttributes setValue:@(NSUnderlineStyleSingle) forKey:NSStrikethroughStyleAttributeName];
    
    [self.sut fm_markAsValid:NO];
    
    NSDictionary *attributes = [self.sut.attributedText attributesAtIndex:0 effectiveRange:NULL];
    XCTAssertTrue([attributes isEqualToDictionary:[invalidAttributes copy]]);
}


- (void)testLabelShouldRemoveStrikethroughTextWhenRemarkingAsValid
{

    NSMutableDictionary *invalidAttributes = [self.defaultAttributes mutableCopy];
    [invalidAttributes setValue:self.textColor forKey:NSForegroundColorAttributeName];
 
    [self.sut fm_markAsValid:NO];
    
    [self.sut fm_markAsValid:YES];
    
    NSDictionary *attributes = [self.sut.attributedText attributesAtIndex:0 effectiveRange:NULL];
    XCTAssertTrue([attributes isEqualToDictionary:[invalidAttributes copy]]);
}


- (void)testLabelShouldStrikethroughTextWhenMarkingActiveAsValid
{

    NSMutableDictionary *invalidAttributes = [self.defaultAttributes mutableCopy];
    [invalidAttributes setValue:@(NSUnderlineStyleSingle) forKey:NSStrikethroughStyleAttributeName];
    [invalidAttributes setValue:self.tintColor forKey:NSForegroundColorAttributeName];
    
    [self.sut fm_markAsActive:YES];
    
    [self.sut fm_markAsValid:NO];
    
    NSDictionary *attributes = [self.sut.attributedText attributesAtIndex:0 effectiveRange:NULL];
    XCTAssertTrue([attributes isEqualToDictionary:[invalidAttributes copy]]);
}


- (void)testLabelShouldUpdateAttributedTextWhenUsingHelperMethod
{

    NSDictionary *attributes = [self.sut.attributedText attributesAtIndex:0 effectiveRange:NULL];
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:@"Hello" attributes:attributes];
    
    [self.sut fm_setAttributedText:@"Hello"];
    
    XCTAssertEqualObjects(self.sut.attributedText, attributedText);
}




@end
