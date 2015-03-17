//
//  ViewController.h
//  Wokoy
//
//  Created by Mitchell on 07/13/14.
//  Copyright (c) 2014 Wokoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITextViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideButton;


@end
