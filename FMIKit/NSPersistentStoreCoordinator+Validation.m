//
//  NSPersistentStoreCoordinator+Validation.m
//
//  Created by Florian Mielke on 7/8/11.
//  Copyright 2011 Florian Mielke. All rights reserved.
//

#import "NSPersistentStoreCoordinator+Validation.h"


@implementation NSPersistentStoreCoordinator (Validation)


+ (BOOL)isValidPersistentStoreAtURL:(NSURL *)url ofType:(NSString *)type containsEntityWithName:(NSString *)entityName
{
	if (![url isFileURL]) {
		return NO;
	}
	
	BOOL isValid = NO;
	NSError *error = nil;
	NSDictionary *persistentStoreMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:type URL:url error:&error];
	
	// 2. Validate the file is a pesristent store
	if (!error)
	{
		NSDictionary *storeModelVersionHashes = [persistentStoreMetadata objectForKey:@"NSStoreModelVersionHashes"];
		
		// 3. Validate the store type
		if ([[persistentStoreMetadata objectForKey:@"NSStoreType"] isEqualToString:type]) 
		{
			// 4. Validate the entity name
			if (!entityName) 
			{
				isValid = YES;
			}
			else if ([storeModelVersionHashes objectForKey:entityName])
			{
				isValid = YES;
			}
		}		
	} 

	return isValid;
}


@end
