//
//  LoginPage.m
//  Social Saver
//
//  Created by Greg Kelman on 7/23/14.
//  Copyright (c) 2015 Social Saver. All rights reserved.
//

#import "LoginPage.h"
#import <Parse/Parse.h>

@interface LoginPage ()

@end

@implementation LoginPage

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
CGFloat animatedDistance;

@synthesize activityUI,forgotPassUI,LoginPageUI,userUI,emailTextUI,passwordTextUI,socialPicUI;

bool isFound = false;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    //LoginPage*vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginPage"];
    
    
    //navController.navigationBar = yes;
    self.emailTextUI.delegate = self;
    self.passwordTextUI.delegate = self;
    isFound = false;
    // Do any additional setup after loading the view.
    [self checkStatus];
}

- (void)viewDidAppear:(BOOL)animated {
    // NSLog(@"Splash - viewDidAppear"); // [self checkStatus];
}


- (void)checkStatus {
    // NSLog(@"Splash - checkStatus");
    [activityUI startAnimating];
    [forgotPassUI setHidden:YES];
    [LoginPageUI setHidden:YES];
    [userUI setHidden:YES];
    [emailTextUI setHidden:YES];
    [passwordTextUI setHidden:YES];
    [socialPicUI setHidden:YES];
    
    if ([PFUser currentUser]) { //if logged in will go to splash screen and populate the nagivation drawer.. maybe do navigation drawer from the beginning
        [self performSegueWithIdentifier:@"splashToMain2" sender:self];
        //[self performSegueWithIdentifier:@"sw_rear" sender:self]; //this could actually mess it up?
        
    } else {
        [activityUI stopAnimating];
        [forgotPassUI setHidden:NO];
        [LoginPageUI setHidden:NO];
        [userUI setHidden:NO];
        [socialPicUI setHidden:NO];
        [emailTextUI setHidden:NO];
        [passwordTextUI setHidden:NO];
        
        
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { //allows user to click out of edittext field
    //[self.view endEditing:YES];
    [emailTextUI resignFirstResponder];
    [passwordTextUI resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [emailTextUI resignFirstResponder];
    [passwordTextUI resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)emailaddress:(id)sender {}
- (IBAction)password:(id)sender {}

- (IBAction)loginPressed:(id)sender {
    //check to see if login credentials are valid
    
    NSString *user = [emailTextUI text];
    NSString *pass = [passwordTextUI text];
    
    if ([user length] < 1 || [pass length] < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"Please enter your email and password." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else {
        [activityUI startAnimating];
        [PFUser logInWithUsernameInBackground:user password:pass block:^(PFUser *user, NSError *error) {
            [activityUI stopAnimating];
            if (user) {
                //is will automatically push to the next
                [self performSegueWithIdentifier:@"splashToMain2" sender:self];
                // [self performSegueWithIdentifier:@"sw_rear" sender:self]; //this could actually mess it up?
            } else {
                NSLog(@"%@",error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed." message:@"Invalid Username and/or Password." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
    
    
}

/*
 * Login button to go to screen
 *
 */
- (IBAction)LoginB:(id)sender {
    //check to see if login credentials are valid
    
    NSString *user = [emailTextUI text];
    NSString *pass = [passwordTextUI text];
    
    if ([user length] < 1 || [pass length] < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"Please enter your email and password." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else {
        [activityUI startAnimating];
        [PFUser logInWithUsernameInBackground:user password:pass block:^(PFUser *user, NSError *error) {
            [activityUI stopAnimating];
            if (user) {
                //is will automatically push to the next
                
                /*
                 COULD WORK ON MATCHING A USERS FOUND DEAL TO WANTED DEALS AND DISPLAY TO USER!
                 */
                
                PFQuery *deals = [PFQuery queryWithClassName:@"SeekingDeals"];
                PFQuery *Fdeals = [PFQuery queryWithClassName:@"FoundDeals"];
                
                NSString *useremail = [[PFUser currentUser] objectForKey:@"username"];
                [deals whereKey:@"userEmail" equalTo:useremail ];
                
                NSArray *objects = [deals findObjects];
                
                //[deals findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
           
                   // if (!error) {
                        for (PFObject *object in objects) {
                            NSString *itemName = [object objectForKey:@"item"];
                            NSNumber *price = [object objectForKey:@"maxPrice"];
                            
                            
                            //[Fdeals findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                NSArray * objects2 = [Fdeals findObjects];
                                //if (!error) {
                                    for (PFObject *object2 in objects2) {
                                        NSString *item = [object2 objectForKey:@"item"];
                                        NSNumber *priceFound = [object2 objectForKey:@"maxPrice"];
                                        
                                        if ([ [itemName lowercaseString] isEqualToString:[item lowercaseString]]){
                                            
                                            if ( [price doubleValue] >= [priceFound doubleValue] ) {
                                                isFound = true;
                                                bool isFriends = false;
                                                /*
                                                PFQuery *Friends = [PFQuery queryWithClassName:@"Friends"];
                                                [Friends findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                                
                                                 if (!error) {
                                                     for (PFObject *object3 in objects) {
                                                         
                                                     }
                                                 }
                                                
                                                }];
                                                */
                                            
                                            }
                                        }

                                    }
                        }


                if(isFound) {
                    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"There are some new deals that match your wanted deals. View them now?"
                                                                          message:nil
                                                                         delegate:self
                                                                cancelButtonTitle:@"No"
                                                                otherButtonTitles: @"Yes",nil];
                    [myAlertView show];

                } else {
                    [self performSegueWithIdentifier:@"splashToMain2" sender:self];
                }
                
                /*
                 * send to main screen
                 */
                //[self performSegueWithIdentifier:@"splashToMain2" sender:self];
                
            } else {
                NSLog(@"%@",error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed." message:@"Invalid Username and/or Password." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"No"]) {
        [self performSegueWithIdentifier:@"splashToMain2" sender:self];
    }
    else if([title isEqualToString:@"Yes"]) {
        [self performSegueWithIdentifier:@"toViewList" sender:self];
        
        //segue to another place to show listings
        /*
        //delete listing and go back to my listings
        PFObject *object = [PFObject objectWithoutDataWithClassName:@"Friends"objectId:aobjectid];
        [object deleteEventually];
        UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"Friend deleted" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [alert1 show];
        [self performSelector:@selector(dismiss:) withObject:alert1 afterDelay:2.0];
        
        [self performSegueWithIdentifier:@"backToHome" sender:self];
        //backToListings
         */
    }
    
}

-(void)dismiss:(UIAlertView*)alert{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (IBAction)NewUserB:(id)sender {
    [self performSegueWithIdentifier:@"splashToNewUser" sender:self];
}

/*
 * forgot password button to send email to users email to reset password
 *
 */
- (IBAction)ForgotPassword:(id)sender {
    NSString *userEmail = [emailTextUI text];
    if([userEmail length] > 0){ //its not empty
        
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" equalTo:userEmail]; // find all the women
        NSArray *userReal = [query findObjects];
        if([userReal count] == 0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"We dont have an email like that in our database. Please check the email address again" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
        }
        else{ //there is such user so lets now reset their email
            [PFUser requestPasswordResetForEmailInBackground:userEmail];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Check your email to reset your password.\n(check your junk folder just in case)" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
        }
    } //end if statement
    else{ //its empty
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops :/" message:@"Please type in your email address used to initally sign up in the email field" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
}



- (IBAction)resetPassword:(id)sender {
    
    NSString *userEmail = [emailTextUI text];
    if([userEmail length] > 0){ //its not empty
        
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" equalTo:userEmail]; // find all the women
        NSArray *userReal = [query findObjects];
        if([userReal count] == 0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"We dont have an email like that in our database. Please check the email address again" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
        }
        else{ //there is such user so lets now reset their email
            [PFUser requestPasswordResetForEmailInBackground:userEmail];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Check your email to reset your password.\n(check your junk folder just in case)" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
        }
    } //end if statement
    else{ //its empty
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops :/" message:@"Please type in your email address used to initally sign up in the email field" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
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