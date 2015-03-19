//
//  UIViewController+CurrentDeals.h
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/18/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "TableCellWD.h"

@interface WantedDeals : UITableViewController <UITableViewDelegate> {
    NSArray *uitem,*uprice;
}

@property (weak, nonatomic) IBOutlet UITableView *infoTablewd;

@end
