//
//  UIViewController+TableCellCD.h
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/18/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCellCD : UITableViewCell

@property (weak,nonatomic) IBOutlet UILabel *ItemLabel;
@property (weak,nonatomic) IBOutlet UILabel *PriceLabel;
@property (weak,nonatomic) IBOutlet UILabel *FoundLabel;
@property (weak,nonatomic) IBOutlet UILabel *LocationLabel;

@end