//
//  UIViewController+TableCellWD.h
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/18/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCellWD : UITableViewCell

@property (weak,nonatomic) IBOutlet UILabel *ItemLabels;
@property (weak,nonatomic) IBOutlet UILabel *MaxPriceLabel;

@end