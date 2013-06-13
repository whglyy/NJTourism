//
//  EGOQuickPhotoSource.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
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
