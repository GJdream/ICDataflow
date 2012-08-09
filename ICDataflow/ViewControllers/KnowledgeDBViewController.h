//
//  KnowledgeDBViewController.h
//  ICDataflow
//
//  Created by Apple on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KnowledgeDBViewController : UIViewController
{
    IBOutlet UITableView *tableView;
    IBOutlet UIButton *done;
    IBOutlet UILabel *titleLabel;
    
    UIPopoverController *rootPopUpViewController;

    NSMutableArray *kbList;
}
#pragma mark @property
@property(nonatomic,retain)IBOutlet UITableView *tableView;
@property(nonatomic,retain)IBOutlet UIButton *done;
@property(nonatomic,retain)IBOutlet UILabel *titleLabel;
@property(nonatomic,retain) UIPopoverController *rootPopUpViewController;

#pragma mark done Button Clicked
- (IBAction)done:(id)sender;

@end
