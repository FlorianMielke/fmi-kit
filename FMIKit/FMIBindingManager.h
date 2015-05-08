//
//  FMIBindingManager.h
//
//  Created by Florian Mielke on 10.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;


/**
 *  Maintains a set of KVO observers, automatically copying values when they change.
 */
@interface FMIBindingManager : NSObject

/**
 *  Establishes a binding between a given property of the observer and the property of a given subject specified by a given key path.
 *  @param  observer The object that should observe subject.
 *  @param  observerKeyPath  The key path for a property of the observer.
 *  @param  subject  The bound-to object.
 *  @param  subjectKeyPath   A key path to a property reachable from subject. The elements in the path must be key-value observing compliant.
 */
- (void)bindObserver:(NSObject *)observer keyPath:(NSString *)observerKeyPath toSubject:(NSObject *)subject keyPath:(NSString *)subjectKeyPath;

/**
 *  Binds an observer's value specified by key path to a subject object's value, transformed using the specified block.
 *  @param  observer The object that should observe subject.
 *  @param  observerKeyPath  The key path for a property of the observer.
 *  @param  subject  The bound-to object.
 *  @param  subjectKeyPath   A key path to a property reachable from subject. The elements in the path must be key-value observing compliant.
 *  @param  transformBlock   The block of code to transformv the property value of subjectKeyPath from one representation to another.
 */
- (void)bindObserver:(NSObject *)observer keyPath:(NSString *)observerKeyPath toSubject:(NSObject *)subject keyPath:(NSString *)subjectKeyPath withValueTransform:(id(^)(id value))transformBlock;

/**
 *  Returns YES if the binding manager is enabled, otherwise NO.
 *  @note   A binding manager is not enabled until its -enable method is called.
 */
- (BOOL)isEnabled;

/**
 *  Activates binding behavior.
 *  @note   This will immediately copy current values of subjects to the observers, and changes will be propagated.
 *  @see    FMIBinding
 */
- (void)enable;

/**
 *  Stops binding behavior.
 */
- (void)disable;

/**
 *  Clears list of bindings.
 */
- (void)removeAllBindings;

@end
