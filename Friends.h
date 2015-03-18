//
//  UIViewController+Friends.h
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/17/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Friends : UIViewController <UITextViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
- (IBAction)AddFriend:(id)sender;

@end
