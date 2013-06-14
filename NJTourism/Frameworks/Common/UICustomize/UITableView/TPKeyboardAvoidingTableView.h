//
//  TPKeyboardAvoidingTableView.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
@interface TPKeyboardAvoidingTableView : UITableView {
    UIEdgeInsets    _priorInset;
    BOOL            _keyboardVisible;
    CGRect          _keyboardRect;
}
- (void)adjustOffsetToIdealIfNeeded;
@end
