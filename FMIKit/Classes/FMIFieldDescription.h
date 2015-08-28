//
//  FMIFieldDescription.h
//
//  Created by Florian Mielke on 02.05.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, FMFieldType){
    FMFieldTypeUndefined = 0,
    FMFieldTypeInteger64 = 300,
    FMFieldTypeDouble = 500,
    FMFieldTypeFloat = 600,
    FMFieldTypeString = 700,
    FMFieldTypeBoolean = 800,
    FMFieldTypeDate = 900
};


/**
 * An FMIFieldDescription object describes a field in a CSV file or a JSON object.
 */
@interface FMIFieldDescription : NSObject

/**
 * The default value for the receiver.
 */
@property (NS_NONATOMIC_IOSONLY) id defaultValue;

/**
 * The name of the field the receiver describes.
 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *name;

/**
 * An FMFieldType constant that specifies the type for the receiver.
 */
@property (NS_NONATOMIC_IOSONLY) FMFieldType type;

@end