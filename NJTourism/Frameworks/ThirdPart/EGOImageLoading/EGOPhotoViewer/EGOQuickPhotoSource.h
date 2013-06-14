//
//  EGOQuickPhotoSource.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import "EGOPhotoGlobal.h"
@interface EGOQuickPhotoSource : NSObject <EGOPhotoSource> {
@private
	NSArray* _photos;
	NSInteger _numberOfPhotos;
}
- (id)initWithPhotos:(NSArray*)photos;
@end
