//
//  ViewPageController.h
//  ICDataflow
//
//  Created by Apple on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICDataflowAppDelegate.h"
#import "Gadget.h"
#import "DataController.h"
#import "WebServiceManager.h"
#import "KnowledgeDBViewController.h"
#import "AcknowledgeViewController.h"

@interface ViewsListController : UIViewController<WebServiceManagerDelegate,UIGestureRecognizerDelegate>
{
    UIPopoverController *popoverController;
    ICDataflowAppDelegate *appdelegate;
    Gadget *gadget;
    DataController *dataControllerObj;
    KnowledgeDBViewController *knowledgeDBViewController;
    AcknowledgeViewController *acknowledgeViewController;
    
    IBOutlet UIScrollView *scrollView;
    UIView *loadingView;

    int refreshInterval;
    int toolBarHieght;
    int expandView;
    int shrinkView;
    int stopAnimation;
    BOOL runAnimation;

    NSMutableArray *originalViewSize;
    NSTimer* timer;
    NSMutableDictionary *animationDictionary;
    NSMutableArray *animationArray;
    NSMutableArray *acknowledgeArray;
    BOOL textToDisplay;
}

#pragma mark @property
@property int expandView;
@property int shrinkView;
@property int stopAnimation;
@property (nonatomic , retain)IBOutlet UIScrollView *scrollView;

#pragma mark set Interval
-(void)setInterval:(int)interval;


#pragma mark Comparing two arrays
-(NSArray *)compareOldValue:(NSMutableArray *)array1 withNewValue:(NSMutableArray *)array2;

#pragma mark Start Timer
-(void)startProcess;

#pragma mark Refreshing at Regular Interval
-(void)retrieveDataInRegularInterval;

#pragma mark animating Gadgets
-(void)animateSphereView:(UIView *)animateView;
-(void)replaceExistingValueAtIndex:(int)index;
-(void)setInterval:(int)interval;

#pragma mark handling Tap Gesture
- (void)handleSingleTap:(UIGestureRecognizer *)gesture;
- (void)handleDoubleTap:(UIGestureRecognizer *)gesture; 

#pragma mark Cancel Button Clicked
-(IBAction)cancelButtonClicked:(id)sender;

#pragma mark Loading Indicator
-(void)startLoadingIndicatorView:(NSString *)labelText;
-(void)stopLoadingIndicatorView;

@end
