//
//  UIViewController+ViewReport.m
//  SocialSaver
//
//  Created by Mitchell Kelman on 3/22/15.
//  Copyright (c) 2015 Mitchell Kelman. All rights reserved.
//

#import "ViewReport.h"

@interface ViewReport (){
    
    //the following strings will be populated depending on what the user choose on the row
    //NSString *name, *email, *rating, *Report, *objectid;
    //PFFile *friendphoto;
}

@end

@implementation ViewReport

@synthesize infoTablevr;
UIActivityIndicatorView *activityIndicator;
NSInteger totalObject;
NSMutableArray *addToArray;// = [[NSMutableArray alloc] init];

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
         addToArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    NSInteger sizeheight = self.view.frame.size.height / 2.0;
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, sizeheight-30);
    [self.view addSubview: activityIndicator];
    
    [activityIndicator startAnimating];
    addToArray = [[NSMutableArray alloc] init];

    [self performSelector:@selector(retrieveFromParse)];
    self.infoTablevr.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
}


-(void)retrieveFromParse {
    
    
    PFQuery *deals = [PFQuery queryWithClassName:@"SeekingDeals"];
    PFQuery *Fdeals = [PFQuery queryWithClassName:@"FoundDeals"];
    NSMutableArray *addToArray;
    NSString *useremail = [[PFUser currentUser] objectForKey:@"username"];
    [deals whereKey:@"userEmail" equalTo:useremail ];
    
    NSArray *objects = [deals findObjects];
    
    //[deals findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    
    // if (!error) {
    for (PFObject *object in objects) {
        NSString *itemName = [object objectForKey:@"item"];
        NSNumber *price = [object objectForKey:@"maxPrice"];
        
        
        //[Fdeals findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSArray * objects2 = [Fdeals findObjects];
        //if (!error) {
        for (PFObject *object2 in objects2) {
            NSString *item = [object2 objectForKey:@"item"];
            NSNumber *priceFound = [object2 objectForKey:@"maxPrice"];
            
            if ([ [itemName lowercaseString] isEqualToString:[item lowercaseString]]){
                
                if ( [price doubleValue] >= [priceFound doubleValue] ) {
                    if (!addToArray) addToArray = [[NSMutableArray alloc] init];
                    [addToArray addObject:object2];
                    
                    //[addToArray addObject:object2];
                    
                    uitems = [[NSArray alloc]initWithArray:addToArray];
                    uprices = [[NSArray alloc]initWithArray:addToArray];
                    ufounds = [[NSArray alloc]initWithArray:addToArray];
                    ulocations = [[NSArray alloc]initWithArray:addToArray];
                     [infoTablevr reloadData];
                    

                }
            }
            
        }
    }

    
    /*
    PFQuery *deals = [PFQuery queryWithClassName:@"FoundDeals"];
    
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
            [self.infoTablevr addSubview:label];
            [activityIndicator stopAnimating]; // end spinning wheel!
     
        }
        [infoTablevr reloadData];
    }];
     */
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    // Return the number of rows in the section.
    return uitems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableCellCD";
    
    TableCellCD *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    PFObject *itemObject = [uitems objectAtIndex:indexPath.row];
    PFObject *priceObject = [uprices objectAtIndex:indexPath.row];
    PFObject *foundObject = [ufounds objectAtIndex:indexPath.row];
    PFObject *locationObject = [ulocations objectAtIndex:indexPath.row];
    
    cell.ItemLabel.text = [itemObject objectForKey:@"item"];
    NSNumber *price = [priceObject objectForKey:@"maxPrice"];
    cell.PriceLabel.text = [price stringValue];
    
    cell.FoundLabel.text = [foundObject objectForKey:@"foundLocation"];
    cell.LocationLabel.text = [locationObject objectForKey:@"actualLocation"];
    
    
    
    [activityIndicator stopAnimating]; // end spinning wheel!
    return cell;
    
}

//user selects folder to add tag to
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"splashToMain2" sender:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)HomeButton:(id)sender {
    [self performSegueWithIdentifier:@"splashToMain2" sender:self];
}
@end