//
//  FMICSVDeserializer.h
//
//  Created by Florian Mielke on 02.05.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMICSVFileDescription;


/**
 * The FMICSVDeserializer class provides methods to convert deserialize CSV files to Foundation objects.
 */
@interface FMICSVDeserializer : NSObject

/**
 * Returns a Boolean value that indicates whether a file at given url can be deserialized.
 * @param fileURL The url of the CSV file.
 * @param fileDescription The description of the CSV file.
 * @param error If an error occurs, upon return contains an NSError object that describes the problem.
 * @return BOOL YES if file at url can be deserialized, otherwise NO.
 */
+ (BOOL)isValidCSVFileAtURL:(NSURL *)fileURL fileDescription:(FMICSVFileDescription *)fileDescription error:(NSError **)error;

/**
 * Returns a list of Foundation objects from a CSV file at a given url.
 * @param fileURL The url to the CSV file.
 * @param fileDescription The description of the CSV file.
 * @param error If an error occurs, upon return contains an NSError object that describes the problem.
 * @return NSArray List of Foundation objects with contents of the file at the given fileURL, otherwise emtpy array when an error occurs.
 */
+ (NSArray *)objectsWithContentsOfFileAtURL:(NSURL *)fileURL fileDescription:(FMICSVFileDescription *)fileDescription error:(NSError **)error;

@end


/**
 * A constant string representing the deserializer error domain.
 */
extern NSString *const FMICSVDeserializerErrorDomain;

/**
 * An enumerated type prepresenting the deserializer error codes.
 */
enum {
    FMICSVDeserializerInvalidLineEndingError,
    FMICSVDeserializerInvalidColumnsError,
};
