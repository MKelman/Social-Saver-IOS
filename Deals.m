//
//  UIViewController+Deals.m
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/17/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import "Deals.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>

@interface Deals (){
    BOOL keyboardShown;
    NSInteger keyboardHeight;
    
}

@end

@implementation Deals

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"deals";
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

@end
