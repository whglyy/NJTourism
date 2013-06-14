//
//  EGOImageViewEx.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import "EGOImageViewEx.h"


@implementation EGOImageViewEx





- (id)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
	
	
	DLog(@"UIImageViewEx touchesBegan \n");
}
//捕获手指拖拽消息
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	
}

//捕获手指拿开消息
- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event{
	
	DLog(@"EGOImageViewEx touchesEnded \n");
	if ([exDelegate_ conformsToProtocol:@protocol(EGOImageViewExDelegate)]) {
		if ([exDelegate_ respondsToSelector:@selector(imageExViewDidOk:)]) {
			[exDelegate_ imageExViewDidOk:self];
		}		
	}
}

- (void)setImageURL:(NSURL *)aURL
{
    if (aURL == nil) {
        self.image = self.placeholderImage;
		imageURL = nil;
        return;
    }
    [self.activityView startAnimating];
    
    if(imageURL) {
		[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:imageURL];
	
		imageURL = nil;
	}
	
	if(!aURL) {
		self.image = self.placeholderImage;
		imageURL = nil;
		return;
	} else {
		imageURL = aURL ;
	}
    
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	NSData* imageData = [[EGOImageLoader sharedImageLoader] dataForURL:aURL shouldLoadWithObserver:self];
	
	if(imageData)
    {
        self.imageFileData = imageData;
        
        [self.activityView stopAnimating];
		// trigger the delegate callback if the image was found in the cache
		if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
			[self.delegate imageViewLoadedImage:self];
		}
	} else {
		self.image = self.placeholderImage;
	}
}


- (void)imageLoaderDidLoad:(NSNotification *)notification
{
    [self.activityView stopAnimating];
    
    [super imageLoaderDidLoad:notification];
}

- (void)imageLoaderDidFailToLoad:(NSNotification *)notification
{
    [self.activityView stopAnimating];
    
    [super imageLoaderDidFailToLoad:notification];
}

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView)
    {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        _activityView.hidesWhenStopped = YES;
        
        _activityView.frame = CGRectMake(self.width/2-10, self.height/2-10, 20, 20);
        
        [self addSubview:_activityView];
    }
    return _activityView;
}



@end
