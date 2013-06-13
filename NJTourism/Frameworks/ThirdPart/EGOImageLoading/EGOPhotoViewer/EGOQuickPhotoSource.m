//
//  EGOQuickPhotoSource.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "EGOQuickPhotoSource.h"


@implementation EGOQuickPhotoSource
@synthesize photos=_photos, numberOfPhotos=_numberOfPhotos;


- (id)initWithPhotos:(NSArray*)photos {
	if (self = [super init]) {
		_photos = [photos retain];
		_numberOfPhotos = [_photos count];
		
	}
	
	return self;
}

- (id<EGOPhoto>)photoAtIndex:(NSInteger)index {
	return [_photos objectAtIndex:index];
}

- (void)dealloc{
	[_photos release], _photos=nil;
	[super dealloc];
}

@end
