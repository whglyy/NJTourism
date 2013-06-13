//
//  TPKeyboardAvoidingTableView.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

@interface TPKeyboardAvoidingTableView : UITableView {
    UIEdgeInsets    _priorInset;
    BOOL            _keyboardVisible;
    CGRect          _keyboardRect;
}

- (void)adjustOffsetToIdealIfNeeded;
@end
