//
//  FriendDetail.h
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/18/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendListViewController.h"

@interface FriendDetail : UIViewController

@property(strong,nonatomic)IBOutlet UILabel *nameL;
@property(strong,nonatomic)IBOutlet UILabel *emailL;
@property(strong,nonatomic)IBOutlet UILabel *ratingL;
@property(strong,nonatomic)IBOutlet UILabel *reportL;
//@property(strong,nonatomic)IBOutlet UIImageView *userimage;

@property(strong,nonatomic)NSString *aname,*aemail, *arating, *areport,*aobjectid;
- (IBAction)RemoveFriend:(id)sender;

@end
