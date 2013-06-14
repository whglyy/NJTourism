//
//  Command.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface Command : NSObject
{

}

+ (id)command;
- (void) execute;
- (void) undo;

@end
