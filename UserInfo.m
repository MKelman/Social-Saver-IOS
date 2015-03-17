//
//  LoginPage.m
//  Social Saver
//
//  Copyright (c) 2015 Social Saver. All rights reserved.
//

#import "UserInfo.h"
#import <Parse/Parse.h>

@interface UserInfo ()

@end

@implementation UserInfo

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
CGFloat animatedDistance;
UIActivityIndicatorView *activityIndicator;

@synthesize nameInfo,emailInfo,passInfo,confirmPassInfo;
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
    self.nameInfo.delegate = self;
    self.emailInfo.delegate = self;
    self.passInfo.delegate = self;
    self.confirmPassInfo.delegate = self;

    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    // NSLog(@"Splash - viewDidAppear"); // [self checkStatus];
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { //allows user to click out of edittext field
    //[self.view endEditing:YES];
    [nameInfo resignFirstResponder];
    [emailInfo resignFirstResponder];
    [passInfo resignFirstResponder];
    [confirmPassInfo resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [nameInfo resignFirstResponder];
    [emailInfo resignFirstResponder];
    [passInfo resignFirstResponder];
    [confirmPassInfo resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SubmitButton:(id)sender {

    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    NSInteger sizeheight = self.view.frame.size.height / 2.0;
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, sizeheight);
    [self.view addSubview: activityIndicator];
    [activityIndicator startAnimating];
    
    NSString *name = [nameInfo text]; //changes to text
    NSString *emailaddress = [emailInfo text];
    NSString *password = [passInfo text];
    NSString *passwordconfirm = [confirmPassInfo text];
    
    if(name.length<=0){
        [activityIndicator stopAnimating];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"Please enter you first name." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else if(emailaddress.length<=0){
        [activityIndicator stopAnimating];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"Please enter your email address." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else if(password.length<=0){
        [activityIndicator stopAnimating];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"Please enter a password." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    else if(passwordconfirm.length<=0){
        [activityIndicator stopAnimating];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"Please confirm your password." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else if(![password isEqual: passwordconfirm] ){
        [activityIndicator stopAnimating];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"Your passwords do not match!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else{
        //awesome, make a user and move to their new home page
        
        PFUser *user = [PFUser user];
        user.username = emailaddress;
        user.password = passwordconfirm;
        user.email = emailaddress;
        
        user[@"name"] = name;
        user[@"reportCount"] = @"0";
        user[@"Rating"] = @"0.0";
        user[@"isOn"] = @"true";
        
        
        
        //initalize the file
        UIImage *image = [UIImage imageNamed:@"black200.png"];
        NSData *imageData = UIImagePNGRepresentation(image);
        PFFile *file = [PFFile fileWithName:@"image.jpg" data:imageData];
        user[@"userImage"] = file;
        
        /* //will this prevent a new installation with a new user?
         PFInstallation *installation = [PFInstallation currentInstallation];
         installation[@"isOn"] = @"true";
         installation[@"useremail"] = emailaddress;
         //[installation setObject:@"isOn" forKey:@"true"];
         //[installation setObject:@"useremail" forKey:emailaddress];
         [installation saveInBackground];
         */
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                // Hooray! Let them use the app now.
                [activityIndicator stopAnimating];
                [self performSegueWithIdentifier:@"toMain2" sender:self];
            } else {
                [activityIndicator stopAnimating];
                NSString *errorString = [error userInfo][@"error"];
                // Show the errorString somewhere and let the user try again.
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:errorString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
            }
        }];
        
        
        
    }
    

}

/*

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


- (IBAction)NewUserB:(id)sender {
    [self performSegueWithIdentifier:@"splashToNewUser" sender:self];
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
*/

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