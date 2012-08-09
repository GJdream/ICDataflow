//
//  ICDataflowViewController.h
//  ICDataflow
//
//  Created by Apple on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceManager.h"
#import "User.h"
#import "DataController.h"

@interface ICDataflowViewController : UIViewController
                                        <WebServiceManagerDelegate,LoginWebServiceManagerDelegate,ReturnUsersServiceManagerDelegate,NSXMLParserDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UIToolbar *toolbar;
    UIView *loadingView;
    
    NSMutableString *currentElementValue;
    NSString *currentElement;
    
    User *user;
    DataController *dataControllerObj;
}

#pragma mark @property
@property(nonatomic , retain)IBOutlet UITextField *username;
@property(nonatomic , retain)IBOutlet UITextField *password;
@property(nonatomic , retain)IBOutlet UIToolbar *toolbar;

#pragma mark Login
-(IBAction)ok:(id)sender;


#pragma mark calling service to find User Details
-(void)returnUserService;


#pragma mark Loading Indicator
-(void)startLoadingIndicatorView:(NSString *)labelText;
-(void)stopLoadingIndicatorView;

@end
