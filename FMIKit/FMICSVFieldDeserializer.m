//
//  FMCSVComponents.m
//
//  Created by Florian Mielke on 02.05.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMICSVFieldDeserializer.h"
#import "FMIFieldDescription.h"

@interface FMICSVFieldDeserializer ()

@property (NS_NONATOMIC_IOSONLY) NSArray *fieldDescriptions;

@end

@implementation FMICSVFieldDeserializer

- (instancetype)initWithFieldDescriptions:(NSArray *)fieldDescriptions {
    if (fieldDescriptions == nil) {
        return nil;
    }

    self = [super init];

    if (self != nil) {
        self.fieldDescriptions = fieldDescriptions;
    }

    return self;
}

- (NSDictionary *)objectsFromFields:(NSArray *)fields {
    if (fields == nil || [fields count] != [self.fieldDescriptions count]) {
        return nil;
    }

    NSMutableDictionary *fieldValues = [NSMutableDictionary dictionaryWithCapacity:[self.fieldDescriptions count]];

    for (NSUInteger fieldIndex = 0; fieldIndex < [self.fieldDescriptions count]; fieldIndex++) {
        FMIFieldDescription *fieldDescription = (self.fieldDescriptions)[fieldIndex];
        id fieldsValue = fields[fieldIndex];

        if (fieldsValue != nil && ![fieldsValue isEqualToString:@""]) {
            fieldsValue = [fieldsValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            fieldsValue = [self objectFromField:fieldsValue withDescriptionType:fieldDescription.type];
        } else {
            fieldsValue = fieldDescription.defaultValue;
        }

        fieldValues[fieldDescription.name] = fieldsValue;
    }

    return [fieldValues copy];
}

- (id)objectFromField:(NSString *)field withDescriptionType:(FMFieldType)descriptionType {
    id fieldValue = [field copy];

    switch (descriptionType) {
        case FMFieldTypeInteger64: {
            fieldValue = @([field integerValue]);
            break;
        }
        case FMFieldTypeBoolean: {
            fieldValue = @([field boolValue]);
            break;
        }
        case FMFieldTypeDate:
        case FMFieldTypeString:
        case FMFieldTypeUndefined:
        case FMFieldTypeDouble:
        case FMFieldTypeFloat: {
            if (field == nil) {
                fieldValue = @"";
            }
            break;
        }
    }

    return fieldValue;
}

@end
