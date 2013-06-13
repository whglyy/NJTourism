//
//  ABRefInitialization.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <CoreFoundation/CoreFoundation.h>

@protocol ABRefInitialization <NSObject>
+ (id) alloc;       // this keeps the compiler happy
- (id) initWithABRef: (CFTypeRef) ref;
@end
