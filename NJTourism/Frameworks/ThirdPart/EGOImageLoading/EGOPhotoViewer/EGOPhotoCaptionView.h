//
//  EGOPhotoCaptionView.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

@interface EGOPhotoCaptionView : UIView {
@private
	UILabel *_textLabel;
	BOOL _hidden;
}
- (void)setCaptionText:(NSString*)text hidden:(BOOL)val;
- (void)setCaptionHidden:(BOOL)hidden;
@end
