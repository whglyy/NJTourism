//
//  Command.h
//  FatFist
//
//  Created by  liukun on 12-11-16.
//  Copyright (c) 2012年 FatFist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Command : NSObject
{

}

+ (id)command;
- (void) execute;
- (void) undo;

@end
