//
//  EGOPhotoCaptionView.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
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
