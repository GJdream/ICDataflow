//
//  KnowledgeDBViewController.m
//  ICDataflow
//
//  Created by Apple on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KnowledgeDBViewController.h"

@interface KnowledgeDBViewController ()

@end

@implementation KnowledgeDBViewController

#pragma mark @synthesize

@synthesize tableView;
@synthesize done;
@synthesize titleLabel;
@synthesize rootPopUpViewController;

#pragma mark UIView methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    kbList = [[NSMutableArray alloc] initWithObjects:
              @"First KB",
              @"Second KB",
              @"Third KB",
              @"Fourth KB",
              @"Fifth KB",
              @"Six KB", nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UITableView Delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [kbList count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return  1;
}
-(UITableViewCell *)tableView:(UITableView *)tableViewObj cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableViewObj dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:SimpleTableIdentifier] ;
        
    }
    cell.textLabel.text = [kbList objectAtIndex:[indexPath row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableViewObj didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
}

#pragma mark done Button Clicked

- (IBAction)done:(id)sender
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [tableView reloadData];
        [self.view removeFromSuperview];  
    }
    else 
    {
        [tableView reloadData];
        [self.rootPopUpViewController dismissPopoverAnimated:YES];
    }

}  


@end
