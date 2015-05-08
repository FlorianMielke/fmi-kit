//
//  FMCSVComponents.h
//
//  Created by Florian Mielke on 02.05.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;


/**
 * A helper class that handles component conversions from CSV data to Foundation objects.
 */
@interface FMICSVFieldDeserializer : NSObject

/**
 * Returns a new components objects for given attribute descriptions.
 * @param attributeDescriptions A attribute descriptions object.
 * @return Returns an initialized components object, or nil if the attribute descriptions object is nil.
 */
- (instancetype)initWithFieldDescriptions:(NSArray *)fieldDescriptions;

/**
 * Returns a dictionary of Foundation objects from given CSV fields.
 * @param columns A list of fields.
 */
- (NSDictionary *)objectsFromFields:(NSArray *)fields;

@end
