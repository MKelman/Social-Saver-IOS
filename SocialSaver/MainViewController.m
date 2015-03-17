//
//  ViewController.m
//  Social Saver
//
//  Copyright (c) 2015 Social Saver. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#define kOFFSET_FOR_KEYBOARD 200.0

@interface MainViewController (){
    BOOL keyboardShown;
    NSInteger keyboardHeight;
    
}

@end

@implementation MainViewController
@synthesize dealType,itemName,maxPrice,saleEnd,saleEndLabel,found,foundLabel,foundLocation;

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
CGFloat animatedDistance;


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"home";
    // Change button color
    _sideButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sideButton.target = self.revealViewController;
    _sideButton.action = @selector(revealToggle:);
    
    // Set the gesture to slide the sidebarviewcontroller
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.itemName.delegate = self;
    self.maxPrice.delegate = self;
    self.saleEnd.delegate = self;
    self.foundLocation.delegate = self;




}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { //allows user to click out of edittext field
    //[self.view endEditing:YES];
    [itemName resignFirstResponder];
    [maxPrice resignFirstResponder];
    [saleEnd resignFirstResponder];
    [foundLocation resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [itemName resignFirstResponder];
    [maxPrice resignFirstResponder];
    [saleEnd resignFirstResponder];
    [foundLocation resignFirstResponder];
    return YES;
}



- (IBAction)submitButton:(id)sender {
    NSString *choice = [dealType titleForSegmentAtIndex : dealType.selectedSegmentIndex];
    if ([choice isEqualToString:@"Found Deal"]) {
        if ( [itemName text].length <= 0
            || [maxPrice text].length <= 0
            || [saleEnd text].length <= 0
            || [foundLocation text].length <= 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"Sorry, not all the fields have been filled in." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
        } else {
            PFObject *foundDeal = [PFObject objectWithClassName:@"FoundDeals"];
            //foundDeal[@"State"] = TOMIstate;

            
        }
    } else {
        if ( [itemName text].length <= 0 || [maxPrice text].length <= 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"Sorry, not all the fields have been filled in." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
        } else {
            PFObject *wantedDeal = [PFObject objectWithClassName:@"SeekingDeals"];
            wantedDeal[@"maxPrice", (NSNumber*)[maxPrice text]];
            //wantedDeal[@"userLocation", point];
            wantedDeal[@"userEmail"] = [[PFUser currentUser]objectForKey:@"email"];
            wantedDeal[@"item", [itemName text]];
            [wantedDeal saveInBackground];

            
        }
    }
    
}

- (IBAction)DealTypeAction:(id)sender {
    NSString *choice = [dealType titleForSegmentAtIndex : dealType.selectedSegmentIndex];
    if ([choice isEqualToString:@"Found Deal"]) {
        [saleEndLabel setHidden:NO];
        [saleEnd setHidden:NO];
        [foundLabel setHidden:NO];
        [found setHidden:NO];
        [foundLocation setHidden:NO];
    } else {
        [saleEndLabel setHidden:YES];
        [saleEnd setHidden:YES];
        [foundLabel setHidden:YES];
        [found setHidden:YES];
        [foundLocation setHidden:YES];
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0){
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0){
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else{
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}




@end











