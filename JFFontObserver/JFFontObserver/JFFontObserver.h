//
//  JFFontObserver.h
//  JFFontObserver
//
//  Created by Jeremy Fuellert on 2015-09-11.
//  Copyright (c) 2015 Jeremy Fuellert. All rights reserved.
//

@import UIKit;

@class JFFontObserver;

/** Update fonts with a given block. */
typedef void (^JFFontUpdate) (void);

/** JFFontObserver is a class that listens to system font change events and fowards it's observation to a given delegate. This is primarily used for UI that requires dynamic font. */
@interface JFFontObserver : NSObject

#pragma mark - Observers
/** Adds a font oberserver with a font update block, does not update fonts immediatly. */
+ (void)addObserver:(id)observer fontUpdateBlock:(JFFontUpdate)fontUpdateBlock;

/** Adds a font oberserver with a font update block and with the option to update fonts immediatly. */
+ (void)addObserver:(id)observer fontUpdateBlock:(JFFontUpdate)fontUpdateBlock updateImmediatly:(BOOL)updateImmediatly;

/** Removes a font oberserver. */
+ (void)removeObserver:(id)observer;

/** Returns a font update block from an associated object. */
+ (JFFontUpdate)fontUpdateBlockForObserver:(id)observer;

@end