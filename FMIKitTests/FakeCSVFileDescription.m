//
//  Created by Florian Mielke on 21.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FakeCSVFileDescription.h"
#import "FMIFieldDescription.h"


@implementation FakeCSVFileDescription

- (instancetype)init
{
    self = [super init];
    
    if (self != nil)
    {
        self.delimiter = @";";
        self.encloser = nil;
        self.fieldDescriptions = [self loadFieldDescriptions];
    }
    
    return self;
}


- (NSArray *)loadFieldDescriptions
{
    FMIFieldDescription *employeeNo = [[FMIFieldDescription alloc] init];
    employeeNo.type = FMFieldTypeInteger64;
    employeeNo.defaultValue = @1;
    employeeNo.name = @"employeeNo";
    
    FMIFieldDescription *managerEmployeeNo = [[FMIFieldDescription alloc] init];
    managerEmployeeNo.type = FMFieldTypeInteger64;
    managerEmployeeNo.defaultValue = @1;
    managerEmployeeNo.name = @"managerEmployeeNo";
    
    FMIFieldDescription *salutation = [[FMIFieldDescription alloc] init];
    salutation.type = FMFieldTypeString;
    salutation.defaultValue = @"Herr";
    salutation.name = @"salutation";
    
    FMIFieldDescription *title = [[FMIFieldDescription alloc] init];
    title.type = FMFieldTypeString;
    title.defaultValue = @"";
    title.name = @"title";
    
    FMIFieldDescription *firstName = [[FMIFieldDescription alloc] init];
    firstName.type = FMFieldTypeString;
    firstName.defaultValue = @"";
    firstName.name = @"firstName";
    
    FMIFieldDescription *lastName = [[FMIFieldDescription alloc] init];
    lastName.type = FMFieldTypeString;
    lastName.defaultValue = @"";
    lastName.name = @"lastName";
    
    FMIFieldDescription *titleLong = [[FMIFieldDescription alloc] init];
    titleLong.type = FMFieldTypeString;
    titleLong.defaultValue = @"";
    titleLong.name = @"titleLong";
    
    FMIFieldDescription *unitValuePriorYear = [[FMIFieldDescription alloc] init];
    unitValuePriorYear.type = FMFieldTypeInteger64;
    unitValuePriorYear.defaultValue = @0;
    unitValuePriorYear.name = @"unitValuePriorYear";
    
    FMIFieldDescription *unitValue = [[FMIFieldDescription alloc] init];
    unitValue.type = FMFieldTypeInteger64;
    unitValue.defaultValue = @0;
    unitValue.name = @"unitValue";
    
    FMIFieldDescription *color = [[FMIFieldDescription alloc] init];
    color.type = FMFieldTypeString;
    color.defaultValue = @"161,28,54";
    color.name = @"color";

    FMIFieldDescription *caption = [[FMIFieldDescription alloc] init];
    caption.type = FMFieldTypeString;
    caption.defaultValue = @"";
    caption.name = @"caption";
    
    return @[managerEmployeeNo, employeeNo, salutation, title, firstName, lastName, titleLong, unitValuePriorYear, unitValue, color, caption];
}



@end
