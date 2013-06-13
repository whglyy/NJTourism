//
//  ABConnection.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <UIKit/UIKit.h>
#import "AibangApi.h"

@interface ABConnection : NSObject <NSURLConnectionDataDelegate> {
    NSMutableData* _bufData;
    NSURLConnection* _connection;
    AibangApi* _callback;
}

@property(nonatomic, retain) NSURLConnection* connection;
@property(nonatomic, assign) AibangApi* callback;
-(void) cancel;
-(void) execute;
@end
