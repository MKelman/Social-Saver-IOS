//
//  UIViewController+Friends.m
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/17/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import "Friends.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>

@interface Friends (){
    BOOL keyboardShown;
    NSInteger keyboardHeight;
    
}

@end

@implementation Friends

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"friends";
    // Change button color
    _menuButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _menuButton.target = self.revealViewController;
    _menuButton.action = @selector(revealToggle:);
    
    // Set the gesture to slide the sidebarviewcontroller
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    // Change button color
    //_optionsButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    //reset the current installation just in case! changed in another installation on another phone!
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AddFriend:(id)sender {
    // pop up screen
    //useremail = [[PFUser currentUser]objectForKey:@"email"];
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Add a friend" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add Friend", nil];
    [av setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    
    // Alert style customization
    [[av textFieldAtIndex:1] setSecureTextEntry:NO];
    [[av textFieldAtIndex:0] setPlaceholder:@"Friend's Name"];
    [[av textFieldAtIndex:1] setPlaceholder:@"Friend's Email"];
    [av show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *name = [[alertView textFieldAtIndex:0].text lowercaseString];
    NSString *email = [[alertView textFieldAtIndex:1].text lowercaseString];
    //NSLog(@"1 %@", name);
    //NSLog(@"2 %@", email);
    if (name.length <= 0 || email.length <= 0) {
        UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"Sorry, not all the fields have been filled in." message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [alert1 show];
        [self performSelector:@selector(dismiss:) withObject:alert1 afterDelay:2.5];
    } else {
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" equalTo:email];
        [query whereKey:@"name" equalTo:name];
        NSArray *user = [query findObjects];
        if ([user count] >= 1) {
             PFObject *addFriend = [PFObject objectWithClassName:@"Friends"];
             addFriend[@"friendOne"] = [[PFUser currentUser]objectForKey:@"username"];
             addFriend[@"friendTwo"] = email;
             [addFriend saveInBackground];
            UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"Friend Added!" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
            [alert1 show];
            [self performSelector:@selector(dismiss:) withObject:alert1 afterDelay:2.5];
            
        } else {
            UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"User not found." message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
            [alert1 show];
            [self performSelector:@selector(dismiss:) withObject:alert1 afterDelay:2.5];
        }
        
    }
}

-(void)dismiss:(UIAlertView*)alert{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

@end












