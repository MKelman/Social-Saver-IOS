//
//  FriendListViewController.m
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/18/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import "FriendListViewController.h"
#import "Friends.h"
//#import "FriendListingsDetail.h"


@interface FriendListViewController (){

    //the following strings will be populated depending on what the user choose on the row
    NSString *name, *email, *rating, *Report;
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
    
    /*
    state = stateOfCollege;
    university = collegeName;
    typeOfClass = classType;
    sortingBy = sortBy;
    tutorsemail = Temail;
    */
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
            label.text = @"You dont have any Open Requests yet.";
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
    
    
    
    
    
    
    
    /*
    
    PFQuery *asFriendOne = [PFQuery queryWithClassName:@"Friends"];
    PFQuery *asFriendTwo = [PFQuery queryWithClassName:@"Friends"];
    NSString *user = [[PFUser currentUser]objectForKey:@"username"];
    [asFriendOne whereKey:@"friendOne" equalTo: user];
    [asFriendTwo whereKey:@"friendTwo" equalTo: user];
    totalObject = 0;
    NSArray* friendOne = [asFriendOne findObjects];
    NSArray* friendTwo = [asFriendTwo findObjects];
    
    if(friendOne.count + friendTwo.count == 0){
        UILabel *label = [[UILabel alloc] init];
        CGRect frame = CGRectMake(0.0, 200.0, 320.0, 80.0); //x,y,width,hight
        label.frame = frame;
        label.numberOfLines = 5;
        label.text = @"You do not have any current friends. Go back to the last page and add a friend!";
        [self.infoTable addSubview:label];
        [activityIndicator stopAnimating]; // end spinning wheel!
        
    } else {
        //NSArray *friendTotal;
        for (int i = 0; i < friendOne.count; i++) {
            NSString *asFriendOne = [[friendOne objectAtIndex:i] objectForKey:@"friendOne"];
            NSString *asFriendTwo = [[friendOne objectAtIndex:i] objectForKey:@"friendTwo"];
            NSString *userInfo = [[PFUser currentUser]objectForKey:@"username"];
            
            if([asFriendOne isEqualToString:userInfo]) {
                PFQuery *query = [PFUser query];
                [query whereKey:@"username" equalTo:asFriendTwo]; // find all the women
                NSArray *user = [query findObjects];
                
                uname = [[NSArray alloc]initWithArray:user];
                uemail = [[NSArray alloc]initWithArray:user];
                ureport = [[NSArray alloc]initWithArray:user];
                urating = [[NSArray alloc]initWithArray:user];
                ufriendphoto = [[NSArray alloc]initWithArray:user];
            } else {
                PFQuery *query = [PFUser query];
                [query whereKey:@"username" equalTo:asFriendOne]; // find all the women
                NSArray *user = [query findObjects];
                
                uname = [[NSArray alloc]initWithArray:user];
                uemail = [[NSArray alloc]initWithArray:user];
                ureport = [[NSArray alloc]initWithArray:user];
                urating = [[NSArray alloc]initWithArray:user];
                ufriendphoto = [[NSArray alloc]initWithArray:user];
            }
            
            [infoTable reloadData];
        }
        
        for (int i = 0; i < friendTwo.count; i++) {
            NSString *asFriendOne = [[friendTwo objectAtIndex:i] objectForKey:@"friendOne"];
            NSString *asFriendTwo = [[friendTwo objectAtIndex:i] objectForKey:@"friendTwo"];
            NSString *userInfo = [[PFUser currentUser]objectForKey:@"username"];
            
            if([asFriendOne isEqualToString:userInfo]) {
                PFQuery *query = [PFUser query];
                [query whereKey:@"username" equalTo:asFriendTwo]; // find all the women
                NSArray *user = [query findObjects];
                
                uname = [[NSArray alloc]initWithArray:user];
                uemail = [[NSArray alloc]initWithArray:user];
                ureport = [[NSArray alloc]initWithArray:user];
                urating = [[NSArray alloc]initWithArray:user];
                ufriendphoto = [[NSArray alloc]initWithArray:user];
            } else {
                PFQuery *query = [PFUser query];
                [query whereKey:@"username" equalTo:asFriendOne]; // find all the women
                NSArray *user = [query findObjects];
                
                uname = [[NSArray alloc]initWithArray:user];
                uemail = [[NSArray alloc]initWithArray:user];
                ureport = [[NSArray alloc]initWithArray:user];
                urating = [[NSArray alloc]initWithArray:user];
                ufriendphoto = [[NSArray alloc]initWithArray:user];
            }
            
           // [infoTable reloadData];
        }
         [infoTable reloadData];
    }
     */


    
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
    
    //PFObject *emailObject = [uemail objectAtIndex:indexPath.row];
    //PFObject *ratingObject = [urating objectAtIndex:indexPath.row];
    //PFObject *reportObject = [ureport objectAtIndex:indexPath.row];
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
        
        name = [tempObject objectForKey:@"name"];
        email = [tempObject objectForKey:@"username"];
        rating = [tempObject objectForKey:@"Rating"];
        Report = [tempObject objectForKey:@"reportCount"];

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
        
        name = [tempObject objectForKey:@"name"];
        email = [tempObject objectForKey:@"username"];
        rating = [tempObject objectForKey:@"Rating"];
        Report = [tempObject objectForKey:@"reportCount"];
        
    }

    
    [activityIndicator stopAnimating]; // end spinning wheel!
    return cell;
    
}


//user selects folder to add tag to
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //this will set all variables to prepare for segue
    
    PFObject *tempObject = [uname objectAtIndex:indexPath.row];
    name = [tempObject objectForKey:@"name"];
    email = [tempObject objectForKey:@"username"];
    rating = [tempObject objectForKey:@"Rating"];
    Report = [tempObject objectForKey:@"reportCount"];
    /*
    PFQuery *getinfo = [PFUser query];
    [getinfo whereKey:@"email" equalTo:tutoremail];
    PFObject *object = [getinfo getFirstObject];
    tutordescription = [object objectForKey:@"userwords"];
    tutortotalrating = [object objectForKey:@"totalrates"];
    tutorrating = [object objectForKey:@"rating"];
    */
    
    [self performSegueWithIdentifier:@"ShowDetails" sender:nil];
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"ShowDetails"]){
        /*
        
        TutorListingsDetail *D1 = [segue destinationViewController];
        D1.aemail = tutoremail;
        D1.aname = tutorname;
        D1.arating = tutorrating;
        
        NSString *priceInString = [tutorprice stringValue];
        D1.aprice = priceInString;
        
        D1.aproductclasstype = productclasstype;
        
        D1.aproducttitle = productitle;
        
        D1.auniversity = currentuniversity;
        
        D1.astate = stateofschool;
        
        D1.aproductid = productobjectid;
        
        D1.auserimage = tutorphoto;
        
        D1.atotalrating = tutortotalrating;
        
        D1.auserdescription = tutordescription;
        */
        //  NSIndexPath *myIndexPath = [self.infoTable indexPathForSelectedRow];
        // int row = [myIndexPath row];
        // tlistingsdetail.DetailModal = @[_title[row]
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
