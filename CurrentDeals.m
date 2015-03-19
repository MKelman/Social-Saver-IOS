//
//  FriendListViewController.m
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/18/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import "CurrentDeals.h"
#import "Deals.h"

@interface CurrentDeals (){
    
    //the following strings will be populated depending on what the user choose on the row
    //NSString *name, *email, *rating, *Report, *objectid;
    //PFFile *friendphoto;
}

@end

@implementation CurrentDeals

@synthesize infoTablecd;
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
    self.infoTablecd.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}


-(void)retrieveFromParse{
    
    PFQuery *deals = [PFQuery queryWithClassName:@"FoundDeals"];
    //NSString *useremail = [[PFUser currentUser] objectForKey:@"username"];
    
    [deals findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            uitem = [[NSArray alloc]initWithArray:objects];
            uprice = [[NSArray alloc]initWithArray:objects];
            ufound = [[NSArray alloc]initWithArray:objects];
            ulocation = [[NSArray alloc]initWithArray:objects];
        }
        if(objects.count == 0){
            UILabel *label = [[UILabel alloc] init];
            CGRect frame = CGRectMake(0.0, 200.0, 320.0, 80.0); //x,y,width,hight
            label.frame = frame;
            label.numberOfLines = 5;
            label.text = @"Sorry, nobody has placed a listing yet for this type of class. Please check back at a later time";
            [self.infoTablecd addSubview:label];
            [activityIndicator stopAnimating]; // end spinning wheel!
            
        }
        [infoTablecd reloadData];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    // Return the number of rows in the section.
    return uitem.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableCellCD";
    
    TableCellCD *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    PFObject *itemObject = [uitem objectAtIndex:indexPath.row];
    PFObject *priceObject = [uprice objectAtIndex:indexPath.row];
    PFObject *foundObject = [ufound objectAtIndex:indexPath.row];
    PFObject *locationObject = [ulocation objectAtIndex:indexPath.row];
    
    cell.ItemLabel.text = [itemObject objectForKey:@"item"];
    NSNumber *price = [priceObject objectForKey:@"maxPrice"];
    cell.PriceLabel.text = [price stringValue];
    
    cell.FoundLabel.text = [foundObject objectForKey:@"foundLocation"];
    cell.LocationLabel.text = [locationObject objectForKey:@"actualLocation"];

    
    
    [activityIndicator stopAnimating]; // end spinning wheel!
    return cell;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
