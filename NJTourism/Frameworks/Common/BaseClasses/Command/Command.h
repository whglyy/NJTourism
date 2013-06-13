//
//  Command.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
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
