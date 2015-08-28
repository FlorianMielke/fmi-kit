//
//  NSObject+AutoDescription.h
//
//  Created by Andrew on 26/3/11.
//  Copyright 2011 ATKit. All rights reserved.
//

#import <Foundation/Foundation.h>

// Description based on Reflection, Format: [ClassName {prop1 = val1; prop2 = val2; }]., SuperClass' properties included (until NSObject).
@interface NSObject (AutoDescription)

// Reflects about self.
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *autoDescription;

@end