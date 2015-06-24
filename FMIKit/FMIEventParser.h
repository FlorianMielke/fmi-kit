//
//  FMIEventParser.h
//
//  Created by Florian Mielke on 23/03/12.
//  Copyright 2011 Florian Mielke. All rights reserved.
//

#import <EventKit/EventKit.h>


/**
 * A FMIEventParser object provides methods to parse calendar events to confirm to the iCalendar format (RFC 5545).
 */
@interface FMIEventParser : NSObject

/**
 * The EKEvent object to parse.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) EKEvent *event;

/**
 * Returns a data object from a given EKEvent instance confirming to iCalendar format (RFC 5545).
 * @param event The event object.
 * @return Returns a NSData object in the iCalendar format, nil if event is nil.
 */
+ (NSData *)dataFromEvent:(EKEvent *)event;

/**
 * The designated initializer.
 * @param event The EKEvent to parse.
 */
- (instancetype)initWithEvent:(EKEvent *)event;

/**
 * Returns a data object confirming to iCalendar format (RFC 5545).
 * @return Returns a NSData object in the iCalendar format, nil if event is nil.
 */
- (NSData *)dataFromEvent;

/**
 * Returns an escaped NSString from a given string.
 * @param aString The string to escape.
 * @return Returns a new NSString where all special characters are escaped.
 * @note Confirming to the iCalendar format (RFC 5545) any backslash, comma and colon character must be escaped with a backslash character.
 */
- (NSString *)escapedStringFromString:(NSString *)aString;

/**
 * Returns a parsed NSString for an iCalendar description property from given notes.
 * @param notes The notes to parse.
 * @return Returns a string object to be used the description property.
 */
- (NSString *)parseDescriptionFromNotes:(NSString *)notes;

/**
 * Returns a parsed NSString for an iCalendar summary property from given title.
 * @param title The title to parse.
 * @return Returns a string object to be used the summary property.
 */
- (NSString *)parseSummaryFromTitle:(NSString *)title;

@end
