//
//  SelectViewController.h
//  ICDataflow
//
//  Created by Apple on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICDataflowAppDelegate.h"
#import "ViewList.h"
#import "DataController.h"
#import "WebServiceManager.h"

@interface SelectViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,NSXMLParserDelegate,RefreshTimeInSecondsDelegate>
{
    ICDataflowAppDelegate *appDelegate;
    IBOutlet UIButton *select;
    IBOutlet UIButton *cancel;
    
    ViewList *viewlistObj;
    DataController *dataControllerObj;
    NSMutableArray *viewList;
    
    NSString *currentElement;
    int interval;

}
#pragma mark @property

@property (strong, nonatomic) IBOutlet UIPickerView *selectViewListPicker;
@property (strong, nonatomic) IBOutlet UIButton *select;
@property (strong, nonatomic) IBOutlet UIButton *cancel;

@property (strong, nonatomic)  NSMutableArray *viewList;

#pragma mark Button Click event
-(IBAction)selectButtonClicked:(id)sender;
-(IBAction)cancelButtonClicked:(id)sender;

#pragma mark calling service to find refreshing Interval
-(void)refreshIntervalService;

@end
