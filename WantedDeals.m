//
//  FriendListViewController.m
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/18/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import "WantedDeals.h"
#import "Deals.h"

@interface WantedDeals (){
    
    //the following strings will be populated depending on what the user choose on the row
    //NSString *name, *email, *rating, *Report, *objectid;
    //PFFile *friendphoto;
}

@end

@implementation WantedDeals

@synthesize infoTablewd;
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
    self.infoTablewd.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}


-(void)retrieveFromParse{
    
    PFQuery *deals = [PFQuery queryWithClassName:@"SeekingDeals"];
    NSString *useremail = [[PFUser currentUser] objectForKey:@"username"];
    [deals whereKey:@"userEmail" equalTo:useremail ];
    [deals findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            uitem = [[NSArray alloc]initWithArray:objects];
            uprice = [[NSArray alloc]initWithArray:objects];
        }
        if(objects.count == 0){
            UILabel *label = [[UILabel alloc] init];
            CGRect frame = CGRectMake(0.0, 200.0, 320.0, 80.0); //x,y,width,hight
            label.frame = frame;
            label.numberOfLines = 5;
            label.text = @"You current dont have any wanted deals.";
            [self.infoTablewd addSubview:label];
            [activityIndicator stopAnimating]; // end spinning wheel!
            
        }
        [infoTablewd reloadData];
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
    static NSString *CellIdentifier = @"TableCellWD";
    
    TableCellWD *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    PFObject *itemObject = [uitem objectAtIndex:indexPath.row];
    PFObject *priceObject = [uprice objectAtIndex:indexPath.row];

    
    cell.ItemLabels.text = [itemObject objectForKey:@"item"];
    NSNumber *price = [priceObject objectForKey:@"maxPrice"];
    
    cell.MaxPriceLabel.text = [price stringValue];//[priceObject objectForKey:@"maxPrice"];

    
    [activityIndicator stopAnimating]; // end spinning wheel!
    return cell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end