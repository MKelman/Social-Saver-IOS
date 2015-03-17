//
//  UIViewController+UserInfo.h
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/17/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfo : UIViewController  <UITextFieldDelegate>

- (IBAction)SubmitButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *nameInfo;
@property (weak, nonatomic) IBOutlet UITextField *emailInfo;
@property (weak, nonatomic) IBOutlet UITextField *passInfo;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassInfo;

@end
