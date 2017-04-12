//
//  JFFontObserver.m
//  JFFontObserver
//
//  Created by Jeremy Fuellert on 2015-09-11.
//  Copyright (c) 2015 Jeremy Fuellert. All rights reserved.
//

#import "JFFontObserver.h"

@interface JFFontObserver ()

@property (nonatomic, strong) NSMapTable *observers;

@end

@implementation JFFontObserver

#pragma mark - Init
- (instancetype)init {
    
    self = [super init];
    if(self) {
        self.observers = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsCopyIn capacity:50];
        
#if !TARGET_OS_MAC
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateFonts) name:UIContentSizeCategoryDidChangeNotification object:nil];
#endif
    }
    return self;
}

#pragma mark - Observers
#pragma mark - Add
+ (void)addObserver:(id)observer fontUpdateBlock:(JFFontUpdate)fontUpdateBlock {
    
    [[self class] addObserver:observer fontUpdateBlock:fontUpdateBlock updateImmediatly:NO];
}

+ (void)addObserver:(id)observer fontUpdateBlock:(JFFontUpdate)fontUpdateBlock updateImmediatly:(BOOL)updateImmediatly {
    
#if !TARGET_OS_MAC
    [[[self class] sharedDynamicFontObserver] addObserver:observer fontUpdateBlock:fontUpdateBlock updateImmediatly:updateImmediatly];
#else
    [[[self class] sharedDynamicFontObserver] addObserver:observer fontUpdateBlock:fontUpdateBlock updateImmediatly:YES];
#endif
}

- (void)addObserver:(id)observer fontUpdateBlock:(JFFontUpdate)fontUpdateBlock {
    
    [self addObserver:observer fontUpdateBlock:fontUpdateBlock updateImmediatly:NO];
}

- (void)addObserver:(id)observer fontUpdateBlock:(JFFontUpdate)fontUpdateBlock updateImmediatly:(BOOL)updateImmediatly {
    
    NSAssert([observer isKindOfClass:[NSObject class]], @"%@ must be an NSObject class or subclass.", observer);
    NSAssert(fontUpdateBlock, @"Font update block must not be nil for object : %@", observer);
    
    //Set observer and font update block
    [self.observers setObject:[fontUpdateBlock copy] forKey:observer];
    
    if(updateImmediatly) {
        fontUpdateBlock();
    }
}

#pragma mark - Remove
+ (void)removeObserver:(id)observer {
    
    [[[self class] sharedDynamicFontObserver] removeObserver:observer];
}

- (void)removeObserver:(id)observer {
    
    [self.observers removeObjectForKey:observer];
}

#pragma mark - Font update block for observer
+ (JFFontUpdate)fontUpdateBlockForObserver:(id)observer {
    
    return [[[self class] sharedDynamicFontObserver] fontUpdateBlockForObserver:observer];
}

- (JFFontUpdate)fontUpdateBlockForObserver:(id)observer {
    
    NSAssert([observer isKindOfClass:[NSObject class]], @"%@ must be an NSObject class or subclass.", observer);
    
    return [self.observers objectForKey:observer];
}

#pragma mark - Updates
- (void)updateFonts {
    
    for(JFFontUpdate fontUpdateBlock in self.observers.objectEnumerator) {
        fontUpdateBlock();
    }
}

#pragma mark - Singleton instance
+ (instancetype)sharedDynamicFontObserver {
    
    static dispatch_once_t pred;
    static JFFontObserver *singletonInstance = nil;
    
    dispatch_once(&pred, ^{
        singletonInstance = [[JFFontObserver alloc] init];
    });
    
    return singletonInstance;
}

#pragma mark - Dealloc
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
