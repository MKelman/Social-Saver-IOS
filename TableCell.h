//
//  UITableViewCell+TableCell.h
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/18/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UILabel *UserNameLabel;
@property (weak,nonatomic) IBOutlet UILabel *EmailLabel;
@property (weak,nonatomic) IBOutlet UILabel *RatingLabel;
@property (weak,nonatomic) IBOutlet UILabel *ReportCountLabel;
@property (weak,nonatomic) IBOutlet UIImageView *ImageLabel;

@end

