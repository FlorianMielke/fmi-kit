//
//  FMIDuration.h
//
//  Created by Florian Mielke on 09.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	FMIDuration objects represent a timeinterval. FMIDuration is a class cluster; its single public superclass, FMIDuration, declares the programmatic
 *  interface for specific and relative timeinterval values. The objects you create using FMIDuration are referred to as timeinterval objects. They 
 *  are immutable objects.
 */
@interface FMIDuration : NSObject <NSCopying, NSCoding>

/**
 *	Returns the interval of the receiver.
 *	@return	The interval.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) NSTimeInterval timeInterval;

/**
 *	Returns a Boolean that indicates whether the receiver is negative or not.
 *	@return	YES if the receiver is negative, otherwise NO.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) BOOL isNegative;

/**
 *	Returns the hours unit of the receiver.
 *	@return	The hours unit.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) NSInteger hours;

/**
 *	Returns the minutes unit of the receiver.
 *	@return	The minutes unit.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) NSInteger minutes;

/**
 *	Returns the seconds unit of the receiver.
 *	@return	The seconds unit.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) NSInteger seconds;

/**
 *	Creates and returns an FMIDuration object set to 0 seconds.
 *	@return	An FMIDuration object initialized with 0 seconds.
 */
+ (FMIDuration *)zero;

/**
 *	Creates and returns an FMIDuration object set to a given number of seconds.
 *	@param	seconds	The number of seconds.
 *	@return	An FMIDuration object initialized with seconds.
 */
+ (FMIDuration *)durationWithTimeInterval:(NSTimeInterval)seconds;

/**
 * Returns an FMIDuration object equivalent to 24 hours in seconds.
 * @return An FMIDuration object equivalent to 24 hours in seconds.
 */
+ (FMIDuration *)twentyFourHours;

/**
 *	Returns an FMIDuration object initialized with a given number of seconds.
 *	@param	seconds	The number of seconds.
 *	@return	A new duration.
 */
- (instancetype)initWithTimeInterval:(NSTimeInterval)seconds NS_DESIGNATED_INITIALIZER;

/**
 *	Returns an FMIDuration object initialized from data in the given unarchiver.
 *	@param	aDecoder	Coder from which to initialize the step.
 *	@return	A new duration.
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 *	Returns an NSComparisonResult value that indicates the temporal ordering of the receiver and another given duration.
 *	@param	anotherDuration	The duration with which to compare the receiver.
 *	@return	If:
 *  The receiver and anotherDuration are exactly equal to each other, NSOrderedSame.
 *  The receiver is bigger than anotherDuration, NSOrderedDescending.
 *  The receiver is smaller than anotherDuration, NSOrderedAscending.
 */
- (NSComparisonResult)compare:(FMIDuration *)anotherDuration;

- (NSDecimal)decimalValue;

/**
 *  Returns a Boolean value that indicates whether the receiver’s time interval and a given duration's time intervals are equal.
 *
 *  @param aDuration The duration to compare to the object’s time interval.
 *
 *  @return YES if the object’s and \c aDuration time intervals are equal, otherwise NO.
 */
- (BOOL)isEqualToDuration:(FMIDuration *)aDuration;

@end
