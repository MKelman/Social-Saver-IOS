//
//  UIViewController+ViewReport.h
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/22/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "TableCellCD.h"

@interface ViewReport : UITableViewController <UITableViewDelegate> {
    NSArray *uitems,*uprices,*ufounds,*ulocations;
}

@property (weak, nonatomic) IBOutlet UITableView *infoTablevr;
- (IBAction)HomeButton:(id)sender;

@end
