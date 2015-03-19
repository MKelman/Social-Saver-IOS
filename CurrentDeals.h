//
//  UIViewController+CurrentDeals.h
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/18/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "TableCellCD.h"

@interface CurrentDeals : UITableViewController <UITableViewDelegate> {
    NSArray *uitem,*uprice,*ufound,*ulocation;
}

@property (weak, nonatomic) IBOutlet UITableView *infoTablecd;

@end
