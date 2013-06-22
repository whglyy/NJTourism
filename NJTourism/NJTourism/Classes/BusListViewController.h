//
//  BusListViewController.h
//  NJTourism
//
//  Created by lyywhg on 13-6-14.
//
//

#import "CommonViewController.h"
#import "ChangeBusView.h"


@interface BusListViewController : CommonViewController<AibangApiDelegate, UITextFieldDelegate, ChangeBusDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *btnImageView;


@end
