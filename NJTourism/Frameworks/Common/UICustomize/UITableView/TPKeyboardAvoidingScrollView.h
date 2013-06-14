//
//  TPKeyboardAvoidingScrollView.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
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
