//
//
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import "SBJsonStreamWriter.h"

@interface SBJsonStreamWriterAccumulator : NSObject <SBJsonStreamWriterDelegate>{
    @private
    NSMutableData *data;
}

@property (readonly, copy) NSData *data;

@end
