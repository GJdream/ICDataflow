//
//  ICDataflowViewController.m
//  ICDataflow
//
//  Created by Apple on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "ICDataflowViewController.h"
#import "SelectViewController.h"
#import "ReturnViewsParser.h"
#import "User.h"

@interface ICDataflowViewController ()

@end

@implementation ICDataflowViewController

#pragma mark @@synthesize

@synthesize username;
@synthesize password;
@synthesize toolbar;

#pragma mark UIView methods

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(user == nil)
    {
        user = [[User alloc] init];
    }
    
    CGRect rectArea = CGRectMake(0, 0 , self.view.frame.size.width , 42);
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:rectArea];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    [toolBar sizeToFit];
    [toolBar setFrame:rectArea];
    [self.view addSubview:toolBar];  
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:toolBar.frame];
    [label setText:@"ICDataflow"];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    UIBarButtonItem *title = [[UIBarButtonItem alloc] initWithCustomView:label];
    [items addObject:title];
    
    toolBar.items =  items; 
}

#pragma mark Login

-(IBAction)ok:(id)sender
{
//    if(([username.text length] != 0) && ([password.text length] != 0))
//    {
//        NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <Login xmlns=\"http://tempuri.org/\"> <Username>%@</Username><Password>%@</Password></Login> </soap:Body> </soap:Envelope>",username.text,password.text];
           
        [self startLoadingIndicatorView:@"Loging in.."];

        NSString *soapMsg = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <Login xmlns=\"http://tempuri.org/\"> <Username>townepark</Username><Password>T0wn3p4rk</Password></Login> </soap:Body> </soap:Envelope>"];
        
        WebServiceManager *webServiceManager = [[WebServiceManager alloc]init];
        
        [webServiceManager setLoginServiceDelegate:self];
        
        [webServiceManager WebserviceRequest:@"http://icdataflow.net/ICDFWS/Service1.asmx?op=Login" andSOAPMsg:soapMsg andSOAPAction:@"http://tempuri.org/Login"];
//    }
//    else 
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter the field properly." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alertView show];
//    }
}

#pragma mark LoginWebServiceManagerDelegate

-(void)LoginwebServicedFinished:(NSData *)data
{
    NSString* output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
//    NSLog(@"webServicedFinished:(NSData *)data=%@",output);
    
    
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];
    
    [nsXmlParser setDelegate:self];
    
    BOOL success = [nsXmlParser parse];
    
    if (success) 
    {

        if([currentElementValue isEqualToString:@"Success"])
        {
             [self returnUserService];
        }
        else if([currentElementValue isEqualToString:@"Invalid username"])
        {
            [self stopLoadingIndicatorView];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Invalid username." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else if([currentElementValue isEqualToString:@"Invalid password"])
        {
            [self stopLoadingIndicatorView];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Invalid password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else 
    {
        [self stopLoadingIndicatorView];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Xml parsing error." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

-(void)LoginwebServicedFailedWithError:(NSError *)error message:(NSString *)message
{
    NSLog(@"webServicedFailedWithError:=%@=%@",[error debugDescription],message);
}

#pragma mark returnuser delegate

-(void)ReturnUsersServicedFinished:(NSData *)data
{
//    NSString* output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
//    NSLog(@"webServicedFinished:(NSData *)data=%@",output);
    
    dataControllerObj = nil;
    if(dataControllerObj == nil)
    {
        dataControllerObj = [[DataController alloc] init];
        [dataControllerObj.GadgetList removeAllObjects];
    }

    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];
    
    [nsXmlParser setDelegate:self];
    
    BOOL success = [nsXmlParser parse];
    
    if (success) 
    {
        [user saveObject:user];
        
        User *userdetail = [user loadObjectWithKey:@"ReturnUser"];
        
        NSString *soapMsg =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ReturnViews xmlns=\"http://tempuri.org/\"><UserID>%@</UserID> </ReturnViews> </soap:Body> </soap:Envelope>",userdetail.UserID];;
        
        WebServiceManager *webServiceManager = [[WebServiceManager alloc]init];
        
        [webServiceManager setServiceDelegate:self];
        
        [webServiceManager WebserviceRequest:@"http://icdataflow.net/ICDFWS/Service1.asmx?op=ReturnViews" andSOAPMsg:soapMsg andSOAPAction:@"http://tempuri.org/ReturnViews"];

    }

}
-(void)ReturnUsersServicedFailedWithError:(NSError *)error message:(NSString *)message
{
    NSLog(@"webServicedFailedWithError:=%@=%@",[error debugDescription],message);
}

#pragma mark calling service to find User Details

-(void)returnUserService
{
    NSString *soapMsg =@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ReturnUser xmlns=\"http://tempuri.org/\"><username>townepark</username> </ReturnUser> </soap:Body> </soap:Envelope>";
    
    WebServiceManager *webServiceManager = [[WebServiceManager alloc]init];
    
    [webServiceManager setReturnUsersServiceDelegate:self];
    
    [webServiceManager WebserviceRequest:@"http://icdataflow.net/ICDFWS/Service1.asmx?op=ReturnUser" andSOAPMsg:soapMsg andSOAPAction:@"http://tempuri.org/ReturnUser"];
}

#pragma mark NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict 
{
    currentElement = [elementName copy];  
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{
    if (([currentElement isEqualToString:@"LoginResult"]))
    {
        currentElementValue = [string mutableCopy];
    }
    if (([currentElement isEqualToString:@"ID"]))
    {
        user.ID = [string copy];
    }
    if (([currentElement isEqualToString:@"Name"]))
    {
        user.Name = [string copy];
    }
    if (([currentElement isEqualToString:@"FirstName"]))
    {      
        user.FirstName = [string copy];
    }
    if (([currentElement isEqualToString:@"LastName"]))
    {
        user.LastName = [string copy];
    }
    if (([currentElement isEqualToString:@"Username"]))
    {
        user.Username = [string copy];
    }
    if (([currentElement isEqualToString:@"PermissionID"]))
    {
        user.PermissionID = [string copy];
    }
    if (([currentElement isEqualToString:@"UserID"]))
    {
        user.UserID = [string copy];
    }
    if (([currentElement isEqualToString:@"PropertyID"]))
    {
        user.PropertyID = [string copy];
    }
    if (([currentElement isEqualToString:@"LocationID"]))
    {
        user.LocationID = [string copy];
    }

    if (([currentElement isEqualToString:@"AccessLevel"]))
    {
        user.AccessLevel = [string copy];
    }
}  

- (void)parser:(NSXMLParser *)parser  didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI  qualifiedName:(NSString *)qName 
{
}

#pragma mark WebServiceManagerDelegate

-(void)webServicedFailedWithError:(NSError *)error message:(NSString *)message
{
    NSLog(@"webServicedFailedWithError:=%@=%@",[error debugDescription],message);
}

-(void)webServicedFinished:(NSData *)data
{
    // NSString* output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
    // NSLog(@"webServicedFinished:(NSData *)data=%@",output);

    ReturnViewsParser *xmlParser = [[ReturnViewsParser alloc] init:data andTemp:0];
    
    [self stopLoadingIndicatorView];

    username.text = @"";
    password.text = @"";
    
    BOOL iPad = NO;
	
	UIStoryboard *mainStoryboard = nil;
	
#ifdef UI_USER_INTERFACE_IDIOM
	iPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#endif
	if (iPad) 
	{
		mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle: nil];
	} 
	else 
	{
		mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
	}
    
	SelectViewController *selectViewController = (SelectViewController*)[mainStoryboard 
                                                    instantiateViewControllerWithIdentifier:@"SelectViewController"];
    
	[[self navigationController] pushViewController:selectViewController animated:YES];

}

#pragma mark textFieldDelegete
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    BOOL iPhone = NO;
	
#ifdef UI_USER_INTERFACE_IDIOM
	iPhone = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
#endif
	if (iPhone) 
	{
        if ([textField isEqual:password]) 
        {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [self.view setFrame:CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height)];
            [UIView commitAnimations];
        }
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    BOOL iPhone = NO;
	
#ifdef UI_USER_INTERFACE_IDIOM
	iPhone = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
#endif
	if (iPhone) 
	{
        if ([textField isEqual:password]) 
        {
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            [UIView commitAnimations];
        }
    }
    return YES;
}


#pragma mark Loading Indicator

-(void)startLoadingIndicatorView:(NSString *)labelText
{
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 90)];
    loadingView.backgroundColor = [UIColor blackColor];
    loadingView.layer.cornerRadius = 10;
    loadingView.layer.borderWidth = 1;
    loadingView.layer.borderColor = [UIColor whiteColor].CGColor;
    loadingView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [self.view addSubview:loadingView];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    CGRect frameSize = CGRectMake(0, 0,40, 40);
    activityIndicator.frame = frameSize;
    [loadingView addSubview:activityIndicator];
    activityIndicator.center = CGPointMake(loadingView.frame.size.width / 2, 70 / 2);
    [activityIndicator startAnimating];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 120, 20)];
    textLabel.text =labelText;
    textLabel.textAlignment = UITextAlignmentCenter;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.backgroundColor = [UIColor clearColor];
    [loadingView addSubview:textLabel];
}

-(void)stopLoadingIndicatorView
{
    for (id view in [loadingView subviews]) 
    {
        [view removeFromSuperview];
    }
    
    [loadingView removeFromSuperview];
}

@end
