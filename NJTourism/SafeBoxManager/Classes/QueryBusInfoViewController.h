//
//  BusListViewController.h
//  NJTourism
//
//  Created by lyywhg on 13-6-14.
//
//

#import "CommonViewController.h"

#import "ChangeBusView.h"
#import "BusLineView.h"


@interface QueryBusInfoViewController : CommonViewController<AibangApiDelegate, UITextFieldDelegate, ChangeBusDelegate, BusLineDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *btnImageView;


@end
