//
//  FriendListViewController.h
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/18/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "TableCell.h"
//#import "FriendListDetail.h"

@interface FriendListViewController : UITableViewController <UITableViewDelegate> {
    NSArray *uname,*uemail,*urating,*ureport,*ufriendphoto;
}

@property (weak, nonatomic) IBOutlet UITableView *infoTable;

@end
