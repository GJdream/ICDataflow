//
//  SelectViewController.m
//  ICDataflow
//
//  Created by Apple on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectViewController.h"
#import "ViewsListController.h"
#import "Gadget.h"
#import "DataController.h"
#import "XmlParser.h"

@interface SelectViewController ()

@end

@implementation SelectViewController

#pragma mark @@synthesize

@synthesize selectViewListPicker = _selectViewListPicker;
@synthesize viewList;
@synthesize select;
@synthesize cancel;


#pragma mark UIView methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (ICDataflowAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    CGRect rectArea = CGRectMake(0, 0 , self.view.frame.size.width , 42);
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:rectArea];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    [toolBar sizeToFit];
    [toolBar setFrame:rectArea];
    [self.view addSubview:toolBar];  
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:toolBar.frame];
    [label setText:@"Select a View"];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    UIBarButtonItem *title = [[UIBarButtonItem alloc] initWithCustomView:label];
    [items addObject:title];
    
    toolBar.items =  items; 
    
    if (_selectViewListPicker == nil) 
	{
		_selectViewListPicker = [[UIPickerView alloc] init];
	}
    if (viewlistObj == nil) 
	{
        viewlistObj = [[ ViewList alloc] init];
    }
    if (dataControllerObj == nil) 
	{
        dataControllerObj = [[DataController alloc] init];
    }
    
    viewlistObj = [dataControllerObj.ViewListArray objectAtIndex:0];
    
    viewList = [[NSMutableArray alloc] initWithArray:viewlistObj.viewList copyItems:YES];
        
    [ _selectViewListPicker setDelegate:self];
	[ _selectViewListPicker setDataSource:self];
    [ _selectViewListPicker reloadAllComponents];
}



#pragma mark UIPickerView Delegate members

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	NSLog(@"You picked the category: %@", [viewList objectAtIndex:row]);
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [viewList count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 
{
	return [viewList objectAtIndex:row];
}

#pragma mark Button Click event

-(IBAction)selectButtonClicked:(id)sender
{
    [self refreshIntervalService];
}

-(IBAction)cancelButtonClicked:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark calling service to find refreshing Interval

-(void)refreshIntervalService
{
    NSString *soapMsg =@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ReturnMobileAppRefreshTimeInSeconds xmlns=\"http://tempuri.org/\" /></soap:Body> </soap:Envelope>";
    
    WebServiceManager *webServiceManager = [[WebServiceManager alloc]init];
    
    [webServiceManager setRefreshTimeDelegate:self];
    
    [webServiceManager WebserviceRequest:@"http://icdataflow.net/ICDFWS/Service1.asmx?op=ReturnMobileAppRefreshTimeInSeconds" andSOAPMsg:soapMsg andSOAPAction:@"http://tempuri.org/ReturnMobileAppRefreshTimeInSeconds"];
}

#pragma mark Refreshing Delegate

-(void)RefreshTimeServicedFinished:(NSData *)data
{
//    NSString* output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
//    NSLog(@"webServicedFinished:(NSData *)data=%@",output);
    
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];
    
    [nsXmlParser setDelegate:self];
    
    BOOL success = [nsXmlParser parse];
    
    if (success) 
    {
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
        
        ViewsListController *viewPageController = (ViewsListController*)[mainStoryboard 
                                                                         instantiateViewControllerWithIdentifier:@"ViewsListController"];
        
        [viewPageController setInterval:interval];
        
        [[self navigationController] pushViewController:viewPageController animated:YES];

    }
}
-(void)RefreshTimeServicedFailedWithError:(NSError *)error message:(NSString *)message
{
    NSLog(@"webServicedFailedWithError:=%@=%@",[error debugDescription],message);
}


#pragma mark NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict 
{
    currentElement = [elementName copy];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{
    if (([currentElement isEqualToString:@"ReturnMobileAppRefreshTimeInSecondsResult"]))
    {
        interval = [[string copy] intValue];
    }
}  

- (void)parser:(NSXMLParser *)parser  didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI  qualifiedName:(NSString *)qName 
{
}
@end
