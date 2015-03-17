//
//  UIViewController+Logout.m
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/17/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import "Logout.h"

#import "SWRevealViewController.h"
#import <Parse/Parse.h>

@interface Logout (){
    BOOL keyboardShown;
    NSInteger keyboardHeight;
    
}

@end

@implementation Logout

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"logout";
    PFInstallation *installation = [PFInstallation currentInstallation];
    installation[@"useremail"] = @"";
    [installation saveInBackground];
    [PFUser logOut];
    [self performSegueWithIdentifier:@"toLogOut" sender:self];

    
       // Change button color
    //_optionsButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    //reset the current installation just in case! changed in another installation on another phone!
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
