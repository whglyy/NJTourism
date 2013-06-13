//
//  EGOQuickPhoto.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>
#import "EGOPhotoGlobal.h"


@interface EGOQuickPhoto : NSObject <EGOPhoto>{
@private
	NSURL *_URL;
	NSString *_caption;
	CGSize _size;
	UIImage *_image;
	
	BOOL _failed;
}

- (id)initWithImageURL:(NSURL*)aURL name:(NSString*)aName image:(UIImage*)aImage;
- (id)initWithImageURL:(NSURL*)aURL name:(NSString*)aName;
- (id)initWithImageURL:(NSURL*)aURL;
- (id)initWithImage:(UIImage*)aImage;

@end
