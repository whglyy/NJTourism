//
//  ABConnection.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "AibangApi.h"

@interface ABConnection : NSObject <NSURLConnectionDataDelegate>
{
}
@property (nonatomic, strong) NSMutableData *bufData;

@property (nonatomic, strong) NSURLConnection* connection;
@property (nonatomic, assign) AibangApi* callback;
-(void) cancel;
-(void) execute;
@end
