//
//  BMKMapManager.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

@protocol BMKGeneralDelegate;

///主引擎类
@interface BMKMapManager : NSObject
{
	
}

/**
*启动引擎
*@param key 申请的有效key
*@param delegate 
*/
-(BOOL)start:(NSString*)key generalDelegate:(id<BMKGeneralDelegate>)delegate;

/**
*停止引擎
*/
-(BOOL)stop;

@end


