//
//
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "SBJsonStreamParserAdapter.h"

@interface SBJsonStreamParserAccumulator : NSObject <SBJsonStreamParserAdapterDelegate>{
    @private
    id value;
}

@property (readonly, copy) id value;

@end
