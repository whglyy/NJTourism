//
//  TPKeyboardAvoidingScrollView.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

@interface TPKeyboardAvoidingScrollView : UIScrollView {
    UIEdgeInsets    _priorInset;
    BOOL            _keyboardVisible;
    CGRect          _keyboardRect;
    CGSize          _originalContentSize;
}

- (void)adjustOffsetToIdealIfNeeded;
@end
