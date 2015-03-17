//
//  ViewController.m
//  Wokoy
//
//  Created by Mitchell Kelman on 07/13/14.
//  Copyright (c) 2014 Wokoy. All rights reserved.
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
NSString *usertext;


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











