//
//  ABRefInitialization.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <CoreFoundation/CoreFoundation.h>

@protocol ABRefInitialization <NSObject>
+ (id) alloc;       // this keeps the compiler happy
- (id) initWithABRef: (CFTypeRef) ref;
@end
