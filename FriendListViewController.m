//
//  FriendListViewController.m
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/18/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import "FriendListViewController.h"
#import "Friends.h"
#import "FriendDetail.h"


@interface FriendListViewController (){

    //the following strings will be populated depending on what the user choose on the row
    NSString *name, *email, *rating, *Report, *objectid;
    PFFile *friendphoto;
}

@end

@implementation FriendListViewController

@synthesize infoTable;// stateOfCollege,collegeName,classType,sortBy,infoTable,imageme,Temail;
UIActivityIndicatorView *activityIndicator;
NSInteger totalObject;


- (void)viewDidLoad{
    [super viewDidLoad];

    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    NSInteger sizeheight = self.view.frame.size.height / 2.0;
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, sizeheight-30);
    [self.view addSubview: activityIndicator];
    
    [activityIndicator startAnimating];
    
    [self performSelector:@selector(retrieveFromParse)];
    self.infoTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //removes unsued lines from table view
    
}


-(void)retrieveFromParse{
    
    PFQuery *astutor = [PFQuery queryWithClassName:@"Friends"];
    PFQuery *asstudent = [PFQuery queryWithClassName:@"Friends"];
    NSString *useremail = [[PFUser currentUser] objectForKey:@"username"];
    
    [astutor whereKey:@"friendOne" equalTo:useremail ];
    [asstudent whereKey:@"friendTwo" equalTo:useremail];
    // [astutor orderByDescending:@"updatedAt"];
    
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[asstudent,astutor]];
    [query orderByDescending:@"updatedAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(objects.count == 0){
            UILabel *label = [[UILabel alloc] init];
            CGRect frame = CGRectMake(0.0, 200.0, 320.0, 80.0); //x,y,width,hight
            label.frame = frame;
            label.numberOfLines = 5;
            label.text = @"You dont have any friends yet.";
            [self.infoTable addSubview:label];
            [activityIndicator stopAnimating];
        } else {
            
            uname = [[NSArray alloc]initWithArray:objects];
            uemail = [[NSArray alloc]initWithArray:objects];
            ureport = [[NSArray alloc]initWithArray:objects];
            urating = [[NSArray alloc]initWithArray:objects];
            ufriendphoto = [[NSArray alloc]initWithArray:objects];
            
        }
        [infoTable reloadData];
    }];

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    // Return the number of rows in the section.
    return uname.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableCell";
    
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    PFObject *nameObject = [uname objectAtIndex:indexPath.row];
    
    PFObject *friendPhotoObject = [ufriendphoto objectAtIndex:indexPath.row];
    
    NSString *asFriendOne = [nameObject objectForKey:@"friendOne"];
    NSString *asFriendTwo = [nameObject objectForKey:@"friendTwo"];
    NSString *userInfo = [[PFUser currentUser]objectForKey:@"username"];

    if ([asFriendOne isEqualToString:userInfo]) {
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" equalTo:asFriendTwo]; // find all the women
        NSArray *user = [query findObjects];
        
        cell.UserNameLabel.text = [[user objectAtIndex:0] objectForKey:@"name"];
        cell.EmailLabel.text = [[user objectAtIndex:0] objectForKey:@"username"];
        NSString *rated = [[user objectAtIndex:0] objectForKey:@"Rating"];
        NSLog(@"%@ / 5.0", rated);
        NSString *full =  [NSString stringWithFormat:@"%@ / 5.0", rated];
        cell.RatingLabel.text = full;
        cell.ReportCountLabel.text = [[user objectAtIndex:0] objectForKey:@"reportCount"];
        
        PFFile *file = [[user objectAtIndex:0] objectForKey:@"userImage"];
        NSData *data = [file getData];
        UIImage *theImage = [UIImage imageWithData:data];
        cell.ImageLabel.image = theImage;
        
        
        PFObject *tempObject = [uname objectAtIndex:indexPath.row];
        objectid = [tempObject objectId];
        name = [[user objectAtIndex:0] objectForKey:@"name"];
        email = [[user objectAtIndex:0] objectForKey:@"username"];
        rating = [[user objectAtIndex:0] objectForKey:@"Rating"];
        Report = [[user objectAtIndex:0] objectForKey:@"reportCount"];

    } else {
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" equalTo:asFriendTwo]; // find all the women
        NSArray *user = [query findObjects];
        
        cell.UserNameLabel.text = [[user objectAtIndex:0] objectForKey:@"name"];
        cell.EmailLabel.text = [[user objectAtIndex:0] objectForKey:@"username"];
        NSString *rated = [[user objectAtIndex:0] objectForKey:@"Rating"];
        NSLog(@"%@ / 5.0", rated);
        NSString *full =  [NSString stringWithFormat:@"%@ / 5.0", rated];
        cell.RatingLabel.text = full;
        cell.ReportCountLabel.text = [[user objectAtIndex:0] objectForKey:@"reportCount"];
        
        PFFile *file = [[user objectAtIndex:0] objectForKey:@"userImage"];
        NSData *data = [file getData];
        UIImage *theImage = [UIImage imageWithData:data];
        cell.ImageLabel.image = theImage;
        
        PFObject *tempObject = [uname objectAtIndex:indexPath.row];
        objectid = [tempObject objectId];
        name = [[user objectAtIndex:0] objectForKey:@"name"];
        email = [[user objectAtIndex:0] objectForKey:@"username"];
        rating = [[user objectAtIndex:0] objectForKey:@"Rating"];
        Report = [[user objectAtIndex:0] objectForKey:@"reportCount"];
        
    }

    
    [activityIndicator stopAnimating]; // end spinning wheel!
    return cell;
    
}


//user selects folder to add tag to
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //this will set all variables to prepare for segue
    
    PFObject *tempObject = [uname objectAtIndex:indexPath.row];
    NSString *asFriendOne = [tempObject objectForKey:@"friendOne"];
    NSString *asFriendTwo = [tempObject objectForKey:@"friendTwo"];
    NSString *userInfo = [[PFUser currentUser]objectForKey:@"username"];
    
    
    if ([asFriendOne isEqualToString:userInfo]) {
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" equalTo:asFriendTwo]; // find all the women
        NSArray *user = [query findObjects];
        
        name = [[user objectAtIndex:0] objectForKey:@"name"];
        email = [[user objectAtIndex:0] objectForKey:@"username"];
        NSString *rated = [[user objectAtIndex:0] objectForKey:@"Rating"];
        NSString *full =  [NSString stringWithFormat:@"%@ / 5.0", rated];
        rating = full;
        Report = [[user objectAtIndex:0] objectForKey:@"reportCount"];
        
    } else {
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" equalTo:asFriendTwo]; // find all the women
        NSArray *user = [query findObjects];
        
        name = [[user objectAtIndex:0] objectForKey:@"name"];
        email = [[user objectAtIndex:0] objectForKey:@"username"];
        NSString *rated = [[user objectAtIndex:0] objectForKey:@"Rating"];
        NSString *full =  [NSString stringWithFormat:@"%@ / 5.0", rated];
        rating = full;
        Report = [[user objectAtIndex:0] objectForKey:@"reportCount"];
        
    }

    
    objectid =  [tempObject objectId];
    [self performSegueWithIdentifier:@"ShowDetails" sender:nil];
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"ShowDetails"]){
        
        FriendDetail *D1 = [segue destinationViewController];
        D1.aemail = email;
        D1.aname = name;
        D1.arating = rating;
        D1.areport = Report;
        D1.aobjectid = objectid;
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
