//
//  ViewController.h
//  Social Saver
//
//  Copyright (c) 2015 Social Saver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITextViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *dealType;
@property (weak, nonatomic) IBOutlet UITextField *itemName;
@property (weak, nonatomic) IBOutlet UITextField *maxPrice;
@property (weak, nonatomic) IBOutlet UILabel *saleEndLabel;
@property (weak, nonatomic) IBOutlet UITextField *saleEnd;
@property (weak, nonatomic) IBOutlet UILabel *foundLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *found;
@property (weak, nonatomic) IBOutlet UITextField *foundLocation;
- (IBAction)submitButton:(id)sender;
- (IBAction)DealTypeAction:(id)sender;




@end
