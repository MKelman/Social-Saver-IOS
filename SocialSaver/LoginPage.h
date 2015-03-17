//
//  LoginPage.h
//  Social Saver
//
//  Created by Greg Kelman on 7/23/14.
//  Copyright (c) 2014 Wokoy Tutoring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginPage : UIViewController  <UITextFieldDelegate>

- (IBAction)LoginB:(id)sender;
- (IBAction)NewUserB:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *forgotPassUI;
@property (weak, nonatomic) IBOutlet UIButton *loginUI;
@property (weak, nonatomic) IBOutlet UIButton *userUI;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityUI;
@property (weak, nonatomic) IBOutlet UIImageView *socialPicUI;
@property (weak, nonatomic) IBOutlet UITextField *emailTextUI;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextUI;
@property (strong, nonatomic) IBOutlet UIView *LoginPageUI;


@end
