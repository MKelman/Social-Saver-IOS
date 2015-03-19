//
//  UIViewController+FriendDetail.m
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/18/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import "FriendDetail.h"

@interface FriendDetail ()

@end

@implementation FriendDetail

@synthesize aname,aemail,arating,areport,aobjectid;//,auserimage;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _nameL.text = aname;
    _emailL.text = aemail;
    _ratingL.text = arating;
    _reportL.text = areport;
    //NSLog(@"%@",aobjectid);
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)RemoveFriend:(id)sender {
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to delete this friend?"
                                                          message:nil
                                                         delegate:self
                                                cancelButtonTitle:@"No"
                                                otherButtonTitles: @"Yes",nil];
    [myAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"No"])
    {
        //it wont do anything and just exit
    }
    else if([title isEqualToString:@"Yes"])
    {
        //delete listing and go back to my listings
        PFObject *object = [PFObject objectWithoutDataWithClassName:@"Friends"objectId:aobjectid];
        [object deleteEventually];
        UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"Friend deleted" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [alert1 show];
        [self performSelector:@selector(dismiss:) withObject:alert1 afterDelay:2.0];
        
        [self performSegueWithIdentifier:@"backToHome" sender:self];
        //backToListings
    }
    
}

-(void)dismiss:(UIAlertView*)alert{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}


@end
