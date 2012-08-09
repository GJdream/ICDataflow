//
//  ViewPageController.m
//  ICDataflow
//
//  Created by Apple on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>


#import "ViewsListController.h"
#import "Gadget.h"
#import "DataController.h"
#import "ReturnViewsParser.h"
#import "KnowledgeDBViewController.h"

@interface ViewsListController ()

@end

@implementation ViewsListController

#pragma mark @synthesize

@synthesize scrollView;
@synthesize expandView;
@synthesize shrinkView;
@synthesize stopAnimation;


NSMutableArray *noDuplicates;
Gadget *lastgadget;
Gadget *currentgadget;

#pragma mark set Interval

-(void)setInterval:(int)interval
{
    refreshInterval = interval;
}

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
    textToDisplay = YES;
    appdelegate = (ICDataflowAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self performSelectorInBackground:@selector(startProcess) withObject:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    runAnimation = NO;
    appdelegate.tag = NO;
    toolBarHieght = 42;
    
    CGRect rectArea = CGRectMake(0, 0 , self.view.frame.size.width , toolBarHieght);
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:rectArea];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    [toolBar sizeToFit];
    [toolBar setFrame:rectArea];
    [self.view addSubview:toolBar];  
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:toolBar.frame];
    [label setText:@"Gadgets"];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    UIBarButtonItem *title = [[UIBarButtonItem alloc] initWithCustomView:label];
    [items addObject:title];
    
    toolBar.items =  items; 
    
    
    if (gadget == nil) 
	{
        gadget = [[ Gadget alloc] init];
    }
    if (dataControllerObj == nil) 
	{
        dataControllerObj = [[DataController alloc] init];
    }
    
    if (animationArray == nil) 
	{
        animationArray = [[NSMutableArray alloc] init];
    }
    if (originalViewSize == nil) 
	{
        originalViewSize = [[NSMutableArray alloc] init];
    }
    
    noDuplicates = [[NSMutableArray alloc] init];

    
    NSLog(@"[dataControllerObj.GadgetList count]  = %d",[dataControllerObj.GadgetList count]);
    
    UIView* view ;
    
    int x = 0, y = 0;
        
    if([dataControllerObj.GadgetList count] > 1)
    {
        for (int i = [dataControllerObj.GadgetList count] - 1; i<[dataControllerObj.GadgetList count]; i++) 
        {
            gadget = [dataControllerObj.GadgetList objectAtIndex:i];
            
            [animationArray removeAllObjects];
            [originalViewSize removeAllObjects];
            
            
            lastgadget = [[ Gadget alloc] init];
            lastgadget = [dataControllerObj.GadgetList objectAtIndex:i-1];

            currentgadget = [[ Gadget alloc] init];
            currentgadget = [dataControllerObj.GadgetList objectAtIndex:i];

            NSMutableArray *fullArray = [[NSMutableArray alloc] init];
            
//            NSLog(@"GadgetNameArray = %@",lastgadget.GadgetNameArray);
//            NSLog(@"GadgetNameArray = %@",lastgadget.LocationNameArray);
//            NSLog(@"GadgetNameArray = %@",lastgadget.ActionDSValueArray);
//            NSLog(@"GadgetNameArray = %@",lastgadget.DisplayDSValueArray);
//            NSLog(@"thresholdArray = %@",lastgadget.thresholdArray);
//            
//            NSLog(@"GadgetNameArray = %@",currentgadget.GadgetNameArray);
//            NSLog(@"GadgetNameArray = %@",currentgadget.LocationNameArray);
//            NSLog(@"GadgetNameArray = %@",currentgadget.ActionDSValueArray);
//            NSLog(@"GadgetNameArray = %@",currentgadget.DisplayDSValueArray);
//            NSLog(@"thresholdArray = %@",currentgadget.thresholdArray);

            
            [fullArray addObjectsFromArray:[self compareOldValue:lastgadget.GadgetNameArray withNewValue:currentgadget.GadgetNameArray]];

            [fullArray addObjectsFromArray:[self compareOldValue:lastgadget.LocationNameArray withNewValue:currentgadget.LocationNameArray]];

            [fullArray addObjectsFromArray: [self compareOldValue:lastgadget.ActionDSValueArray withNewValue:currentgadget.ActionDSValueArray]];

            [fullArray addObjectsFromArray:[self compareOldValue:lastgadget.DisplayDSValueArray withNewValue:currentgadget.DisplayDSValueArray]];

           // [fullArray addObjectsFromArray:[self compareDictionary:lastgadget.thresholdArray withNewValue:currentgadget.thresholdArray]];
            
            NSLog(@"noDuplicates = %@",noDuplicates);
            
            if([lastgadget.GadgetNameArray count] < [currentgadget.GadgetNameArray count])
            {
                for (int loop = [lastgadget.GadgetNameArray count]; loop < [currentgadget.GadgetNameArray count]; loop++)
                {
                    [fullArray addObject:[NSString stringWithFormat:@"%d",loop]];
                }
            }
            
            if([appdelegate.acknowledgeArray count] > 0)
            [fullArray addObjectsFromArray:appdelegate.acknowledgeArray];
            
            [noDuplicates addObjectsFromArray:[[NSSet setWithArray: fullArray] allObjects]];

            NSLog(@"noDuplicates = %@",noDuplicates);
            
            NSLog(@"acknowledgeArray = %@",appdelegate.acknowledgeArray);

        }
    }
    else 
    {
        gadget = [dataControllerObj.GadgetList objectAtIndex:0];
    }
    
    for (id view in [scrollView subviews]) 
    {
        [view removeFromSuperview];
    }
    NSLog(@"gadget.GadgetNameArray = %d",[gadget.GadgetNameArray count]);

    for (int i = 0; i<[gadget.GadgetNameArray count]; i++) 
    {
        NSLog(@"value = %d",i);

        BOOL iPad = NO;
        
        int size;
    #ifdef UI_USER_INTERFACE_IDIOM
        iPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    #endif
        if (iPad) 
        {
            // iPad specific code here
            size = 96;
            x = (i%8) * size;
            y = i/8 * (size + 10) + 10;
        } 
        else 
        {
            // iPhone/iPod specific code here
            size = 80;
            x = (i%4) * size;
            y = i/4 * (size + 10) + 10;
        }
        
        
        view = [[UIView alloc] initWithFrame:CGRectMake(x, y, size, size+10)];
        
        NSMutableDictionary *originalViewSizeDict = [[NSMutableDictionary alloc] init];
        [originalViewSizeDict setObject:[[NSNumber numberWithFloat:view.frame.origin.x] stringValue] forKey:@"x"];
        [originalViewSizeDict setObject:[[NSNumber numberWithFloat:view.frame.origin.y] stringValue] forKey:@"y"];
        [originalViewSizeDict setObject:[[NSNumber numberWithFloat:view.frame.size.width] stringValue] forKey:@"width"];
        [originalViewSizeDict setObject:[[NSNumber numberWithFloat:view.frame.size.height] stringValue] forKey:@"height"];
        [originalViewSize addObject:originalViewSizeDict];
        
        view.tag = i;
        [scrollView addSubview: view];
        
        Thresholds *thresholds = [gadget.thresholdArray objectAtIndex:i];
        
        NSString *color = [self findingColorOfGadget:gadget index:i];
        
        NSLog(@"gadget color =%@",color);

        if([thresholds.Color1 isEqual:@"Green"])
        {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size, size)];           
            imgView.image = [UIImage imageNamed:@"green_sphere.png"];
            [view addSubview: imgView];
        }
        else if([thresholds.Color1 isEqual:@"0"])
        {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size, size)];           
            imgView.image = [UIImage imageNamed:@"yellow_sphere #2.png"];
            [view addSubview: imgView];
        }
        else if([thresholds.Color1 compare:@"(null)" options:NSCaseInsensitiveSearch] == 0)
        {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size, size)];           
            imgView.image = [UIImage imageNamed:@"gray_sphere.png"];
            [view addSubview: imgView];
        }

        CGRect ActionDatastreamFrame;
        CGRect GadgetFrame;
        CGRect LocationFrame;
        CGRect DisplayDatastreamFrame;
        
        #ifdef UI_USER_INTERFACE_IDIOM
        iPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
        #endif
        if (iPad) 
        {
            ActionDatastreamFrame = CGRectMake( 10, 10, size - 20, 20 );
            GadgetFrame = CGRectMake( 10, 35, size - 20, 20 );
            DisplayDatastreamFrame = CGRectMake( 10, 60, size - 20, 20 );
            LocationFrame = CGRectMake( 10, 85, size - 20, 20 );
        } 
        else 
        {
            ActionDatastreamFrame = CGRectMake( 10, 9, size - 20, 20 );
            GadgetFrame = CGRectMake( 10, 30, size - 20, 20 );
            DisplayDatastreamFrame = CGRectMake( 10, 50, size - 20, 20 );
            LocationFrame = CGRectMake( 10, 75, size - 20, 20 );
        }

        UILabel* ActionDatastream = [[UILabel alloc] initWithFrame: ActionDatastreamFrame];
        [ActionDatastream setBackgroundColor:[UIColor clearColor]];
        [ActionDatastream setText: [gadget.ActionDSValueArray objectAtIndex:i]];
        ActionDatastream.font = [UIFont systemFontOfSize:10];
        ActionDatastream.textAlignment = UITextAlignmentCenter;
        [ActionDatastream setTextColor: [UIColor blackColor]];
        [view addSubview: ActionDatastream];
        
        UILabel* GadgetName = [[UILabel alloc] initWithFrame: GadgetFrame];
        [GadgetName setBackgroundColor:[UIColor clearColor]];
        [GadgetName setText: [gadget.GadgetNameArray objectAtIndex:i]];
        GadgetName.font = [UIFont systemFontOfSize:10];
        GadgetName.textAlignment = UITextAlignmentCenter;
        [GadgetName setTextColor: [UIColor blackColor]];
        [view addSubview: GadgetName];
        
        UILabel* DisplayDatastream = [[UILabel alloc] initWithFrame: DisplayDatastreamFrame];
        [DisplayDatastream setBackgroundColor:[UIColor clearColor]];
        if([[gadget.DisplayDSValueArray objectAtIndex:i] intValue] == 0)
            [DisplayDatastream setText:@""];
        else 
            [DisplayDatastream setText: [gadget.DisplayDSValueArray objectAtIndex:i]];
        DisplayDatastream.font = [UIFont systemFontOfSize:10];
        DisplayDatastream.textAlignment = UITextAlignmentCenter;
        [DisplayDatastream setTextColor: [UIColor blackColor]];
        [view addSubview: DisplayDatastream];
        
        UILabel* LocationName = [[UILabel alloc] initWithFrame: LocationFrame];
        [LocationName setBackgroundColor:[UIColor clearColor]];
        [LocationName setText: [gadget.LocationNameArray objectAtIndex:i]];
        LocationName.font = [UIFont systemFontOfSize:10];
        LocationName.textAlignment = UITextAlignmentCenter;
        [LocationName setTextColor: [UIColor whiteColor]];
        [view addSubview: LocationName];
        
        NSString *value = [NSString stringWithFormat:@"%d",i]; 

        UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget : self action : @selector (handleDoubleTap:)];
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget : self action : @selector (handleSingleTap:)];
        
        [singleTap requireGestureRecognizerToFail : doubleTap];
        
        [doubleTap setDelaysTouchesBegan : YES];
        [singleTap setDelaysTouchesBegan : YES];
        
        [doubleTap setNumberOfTapsRequired : 2];
        [singleTap setNumberOfTapsRequired : 1];
        
        [view addGestureRecognizer : doubleTap];
        

        if ([noDuplicates containsObject:value])
        {
            runAnimation = YES;
            stopAnimation = 0;
            expandView = 1;
            shrinkView = 0;
            
            animationDictionary = [[NSMutableDictionary alloc] init];
            
            [animationDictionary setObject:[NSString stringWithFormat:@"%d",stopAnimation] forKey:@"stopAnimation"];
            [animationDictionary setObject:[NSString stringWithFormat:@"%d",expandView] forKey:@"expandView"];
            [animationDictionary setObject:[NSString stringWithFormat:@"%d",shrinkView] forKey:@"shrinkView"];
            
            [animationArray addObject:animationDictionary];
            
            [view addGestureRecognizer : singleTap];
            
            //[self animateSphereView:view];
            [self performSelector:@selector(animateSphereView:) withObject:view afterDelay:0.1];
        }
    }
//    for (int loop = 0; loop < [noDuplicates count] ; loop ++) 
//    {
//        NSLog(@"animationArray = %@",animationArray);
//
//        [self animateSphereView:view];
//    }
    
//    NSMutableArray *fullArray = [[NSMutableArray alloc] init];
//    
//    [fullArray addObjectsFromArray:noDuplicates];
//    
//    [noDuplicates removeAllObjects];
//    
//    [noDuplicates addObjectsFromArray:[[NSSet setWithArray: fullArray] allObjects]];

    scrollView.contentSize = CGSizeMake(320, y+100);
}

#pragma mark Comparing two arrays

-(NSArray *)compareOldValue:(NSMutableArray *)array1 withNewValue:(NSMutableArray *)array2
{
    NSLog(@"compareOldValue");

    NSMutableArray *ary_result = [[NSMutableArray alloc] init];
    for(int i = 0;(i<[array1 count] && i<[array2 count]);i++)
    {
        if([[array1 objectAtIndex:i] isEqualToString:[array2 objectAtIndex:i]])
        {
        }
        else 
        {
            [ary_result addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return  ary_result;
}

-(NSArray *)compareDictionary:(NSMutableArray *)array1 withNewValue:(NSMutableArray *)array2
{
    NSLog(@"compareDictionary");

    NSMutableArray *ary_result = [[NSMutableArray alloc] init];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for(int loop = 0;loop<(([currentgadget.GadgetNameArray count]) && (loop<[lastgadget.GadgetNameArray count]));loop++)
    {
        NSLog(@"gadget. = %@",[currentgadget.thresholdCountOnActionDS objectForKey:[NSString stringWithFormat:@"%d",loop]]);
        NSString *currentCount  =[currentgadget.thresholdCountOnActionDS objectForKey:[NSString stringWithFormat:@"%d",loop]];
        NSString *lastCount  =[currentgadget.thresholdCountOnActionDS objectForKey:[NSString stringWithFormat:@"%d",loop]];

        if([currentCount intValue] == [lastCount intValue])
        {
        for(int i = 0;((i<[array1 count]) && (i<[array2 count]));i++)
        {
            [tempArray removeAllObjects];
            
            NSMutableArray *arrayValue1 = [[NSMutableArray alloc] init];

            Thresholds *thresholds1 = [array1 objectAtIndex:i];
            [arrayValue1 addObject:[thresholds1.ID compare:@"(null)" options:NSCaseInsensitiveSearch] != 0 ? thresholds1.ID: @""]; 
            [arrayValue1 addObject:[thresholds1.Name compare:@"(null)" options:NSCaseInsensitiveSearch] != 0 ? thresholds1.Name: @""]; 
            [arrayValue1 addObject:[thresholds1.Condition compare:@"(null)" options:NSCaseInsensitiveSearch] != 0 ? thresholds1.Condition: @""]; 
            [arrayValue1 addObject:[thresholds1.Operator compare:@"(null)" options:NSCaseInsensitiveSearch] != 0 ? thresholds1.Operator: @""]; 
            [arrayValue1 addObject:[thresholds1.Low compare:@"(null)" options:NSCaseInsensitiveSearch] != 0 ? thresholds1.Low: @""]; 
            [arrayValue1 addObject:[thresholds1.High compare:@"(null)" options:NSCaseInsensitiveSearch] != 0 ? thresholds1.High: @""]; 
            [arrayValue1 addObject:[thresholds1.Color1 compare:@"(null)" options:NSCaseInsensitiveSearch] != 0 ? thresholds1.Color1: @""]; 

            NSMutableArray *arrayValue2 = [[NSMutableArray alloc] init];

            Thresholds *thresholds2 = [array2 objectAtIndex:i];
            [arrayValue2 addObject:[thresholds2.ID compare:@"(null)" options:NSCaseInsensitiveSearch] != 0 ? thresholds2.ID: @""]; 
            [arrayValue2 addObject:[thresholds2.Name compare:@"(null)" options:NSCaseInsensitiveSearch] != 0 ? thresholds2.Name: @""]; 
            [arrayValue2 addObject:[thresholds2.Condition compare:@"(null)" options:NSCaseInsensitiveSearch] != 0 ? thresholds2.Condition: @""]; 
            [arrayValue2 addObject:[thresholds2.Operator compare:@"(null)" options:NSCaseInsensitiveSearch] != 0 ? thresholds2.Operator: @""]; 
            [arrayValue2 addObject:[thresholds2.Low compare:@"(null)" options:NSCaseInsensitiveSearch] != 0 ? thresholds2.Low: @""]; 
            [arrayValue2 addObject:[thresholds2.High compare:@"(null)" options:NSCaseInsensitiveSearch] != 0 ? thresholds2.High: @""]; 
            [arrayValue2 addObject:[thresholds2.Color1 compare:@"(null)" options:NSCaseInsensitiveSearch] != 0 ? thresholds2.Color1: @""]; 

            [tempArray addObjectsFromArray:[self compareOldValue:arrayValue1 withNewValue:arrayValue2]];
            if([tempArray count] > 0)
            {
                [ary_result addObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
        }
        else {
            [ary_result addObject:[NSString stringWithFormat:@"%d",loop]];
        }
    }
    return ary_result;
}


-(NSString *)findingColorOfGadget:(Gadget *)currentGadget index:(int)i
{
    NSLog(@"findingColorOfGadget");

    int value = [[currentGadget.ActionDSValueArray objectAtIndex:i] intValue];
    int high,low;
    BOOL exist = NO;
    NSString *CurrentColor;
    NSLog(@"gadget=%@",[currentGadget.thresholdCountOnActionDS objectForKey:[NSString stringWithFormat:@"%d",i]]);
    int count = [[currentGadget.thresholdCountOnActionDS objectForKey:[NSString stringWithFormat:@"%d",i]] intValue];
    for(int loop = 0; loop < count ; loop ++)
    {
        Thresholds *thresholdToCompare = [currentGadget.thresholdArray objectAtIndex:i + loop];
        high = [thresholdToCompare.High intValue];
        low = [thresholdToCompare.Low intValue];
        if ((value >= low) && (value <= high) && (!exist)) 
        {
            exist = YES;
            CurrentColor = thresholdToCompare.Color1;
        }
    }

    return  CurrentColor;
}

#pragma mark Start Timer

-(void)startProcess
{
    timer = [NSTimer scheduledTimerWithTimeInterval:refreshInterval target:self  selector:@selector(retrieveDataInRegularInterval) userInfo:nil repeats:YES];    
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    [[NSRunLoop currentRunLoop] run]; 
}

#pragma mark Refreshing at Regular Interval

-(void)retrieveDataInRegularInterval
{
    NSLog(@"Refreshing........... ");
    
    runAnimation = NO;
    
    [self startLoadingIndicatorView:@"Refreshing.."];
    
    [appdelegate.acknowledgeArray removeAllObjects];
    
    for (int loop = 0; loop<[noDuplicates count]; loop++) 
    {
        NSMutableDictionary *animationValues = [animationArray objectAtIndex:loop];
        stopAnimation = [[animationValues objectForKey:@"stopAnimation"] intValue];
        expandView = [[animationValues objectForKey:@"expandView"] intValue];
        shrinkView = [[animationValues objectForKey:@"shrinkView"] intValue];
        if(stopAnimation == 0)
        {
            [appdelegate.acknowledgeArray addObject:[noDuplicates objectAtIndex:loop]];
        }
    }
    
    NSString *soapMsg =@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ReturnViews xmlns=\"http://tempuri.org/\"><UserID>118</UserID> </ReturnViews> </soap:Body> </soap:Envelope>";
    
    WebServiceManager *webServiceManager = [[WebServiceManager alloc]init];
    
    [webServiceManager setServiceDelegate:self];
    
    [webServiceManager WebserviceRequest:@"http://icdataflow.net/ICDFWS/Service1.asmx?op=ReturnViews" andSOAPMsg:soapMsg andSOAPAction:@"http://tempuri.org/ReturnViews"];
}


#pragma mark WebServiceManagerDelegate

-(void)webServicedFailedWithError:(NSError *)error message:(NSString *)message
{
    NSLog(@"webServicedFailedWithError:=%@=%@",[error debugDescription],message);
}

-(void)webServicedFinished:(NSData *)data
{
//    NSString* output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
//    NSLog(@"webServicedFinished:(NSData *)data=%@",output);
    
    if (appdelegate.tag) 
    {
//        [appdelegate.acknowledgeArray removeAllObjects];
//        
//        NSLog(@"cancel noDuplicates = %@",noDuplicates);
//        
//        for (int loop = 0; loop<[noDuplicates count]; loop++) 
//        {
//            NSMutableDictionary *animationValues = [animationArray objectAtIndex:loop];
//            stopAnimation = [[animationValues objectForKey:@"stopAnimation"] intValue];
//            expandView = [[animationValues objectForKey:@"expandView"] intValue];
//            shrinkView = [[animationValues objectForKey:@"shrinkView"] intValue];
//            if(stopAnimation == 0)
//            {
//                [appdelegate.acknowledgeArray addObject:[noDuplicates objectAtIndex:loop]];
//            }
//        }
        stopAnimation = 1;
        for (int loop = 0; loop<[animationArray count]; loop++) 
        {
            animationDictionary = [[NSMutableDictionary alloc] init];
            [animationDictionary setObject:[NSString stringWithFormat:@"%d",stopAnimation] forKey:@"stopAnimation"];
            [animationDictionary setObject:[NSString stringWithFormat:@"%d",expandView] forKey:@"expandView"];
            [animationDictionary setObject:[NSString stringWithFormat:@"%d",shrinkView] forKey:@"shrinkView"];
            [animationArray replaceObjectAtIndex:loop withObject:animationDictionary];
        }
        NSLog(@"cancel appdelegate.acknowledgeArray = %@",appdelegate.acknowledgeArray);
        
        [timer invalidate];
        

        ReturnViewsParser *xmlParser = [[ReturnViewsParser alloc] init:data andTemp:1]; 
        [self stopLoadingIndicatorView];
        [[self navigationController] popViewControllerAnimated:YES];
    }
    else {
        ReturnViewsParser *xmlParser = [[ReturnViewsParser alloc] init:data andTemp:1]; 
        [self stopLoadingIndicatorView];
        [self viewWillAppear:YES];
    }
}

#pragma mark animating Gadgets

- (void)animateSphereView:(UIView *)animateView
{   
    NSLog(@"animateSphereView animateView = %d",animateView.tag);
    
    if(!runAnimation)
    {
        return;
    }
    int indexValue = 0;
        
    NSLog(@"animateSphereView noDuplicates = %@",noDuplicates);

    NSString *value = [NSString stringWithFormat:@"%d",animateView.tag]; 

    if ([noDuplicates containsObject:value])
    {
        for (int loop = 0; loop<[noDuplicates count]; loop++) 
        {
            if([[noDuplicates objectAtIndex:loop] isEqual:value])
            {
                indexValue = loop;
            }
        }
        NSLog(@"animateSphereView animationArray = %@",animationArray);

        NSMutableDictionary *animationValues = [animationArray objectAtIndex:indexValue];
        stopAnimation = [[animationValues objectForKey:@"stopAnimation"] intValue];
        expandView = [[animationValues objectForKey:@"expandView"] intValue];
        shrinkView = [[animationValues objectForKey:@"shrinkView"] intValue];
    }
    
    NSLog(@"animateSphereView originalViewSize = %@",originalViewSize);

    if(stopAnimation)
    {
        CGRect frame;
        NSMutableDictionary *originalViewSizeDict = [originalViewSize objectAtIndex:animateView.tag];
        frame.origin.x = [[originalViewSizeDict objectForKey:@"x"] floatValue];
        frame.origin.y = [[originalViewSizeDict objectForKey:@"y"] floatValue];
        frame.size.width = [[originalViewSizeDict objectForKey:@"width"]floatValue];
        frame.size.height = [[originalViewSizeDict objectForKey:@"height"]floatValue];
        NSLog(@"frame = %@",NSStringFromCGRect(frame));
        
        UIView *newView = [[UIView alloc] initWithFrame:frame];
        for (id object in [animateView subviews])
        {
            [newView addSubview:object];
        }
        newView.tag = animateView.tag;
        [animateView removeFromSuperview];

        if (expandView) {
            [UIView animateWithDuration:0.2
                                  delay:0.0
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{ 
                             } 
                             completion:^(BOOL  completed){
                                 if (completed)
                                     expandView = 0;
                                 shrinkView = 1;
                                 [scrollView addSubview:newView];
                                 [self replaceExistingValueAtIndex:indexValue];
                             }                      
             ];
        }
        else
        {
            NSLog(@"stopAnimation shrinkView");
            [UIView animateWithDuration:0.2
                                  delay:0.0
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{ 
                             } 
                             completion:^(BOOL  completed){
                                 if (completed) 
                                     expandView = 1;
                                 shrinkView = 0;
                                 [scrollView addSubview:newView];
                                 [self replaceExistingValueAtIndex:indexValue];
                                 [self animateSphereView:animateView];                  
                             }                   
             ];
        }
//            [UIView animateWithDuration:0.0
//                                  delay:0.0
//                                options:UIViewAnimationOptionAllowUserInteraction
//                             animations:^{ 
//                                // animateView.transform = tr;
//                                 [animateView.layer removeAllAnimations];
//                             } 
//                             completion:^(BOOL  completed){
//                                 if (completed)
//                                     expandView = 0;
//                                 shrinkView = 1;
//                                 [scrollView addSubview:newView];
//
//                                 [self replaceExistingValueAtIndex:indexValue];
//                             }                      
//             ];
        return;
    }
    if (expandView) {
        CGAffineTransform tr = CGAffineTransformScale(animateView.transform, .91, .91);
        [UIView animateWithDuration:0.5 
                              delay:0.0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{ 
                             animateView.transform = tr;
                         } 
                         completion:^(BOOL  completed){
                             if (completed)
                                 expandView = 0;
                             shrinkView = 1;
                             [self replaceExistingValueAtIndex:indexValue];
                             [self animateSphereView:animateView];                  
                         }                      
         ];
    }
    else
    {
        CGAffineTransform tr = CGAffineTransformScale(animateView.transform, 1.10, 1.10);
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{ 
                             animateView.transform = tr;
                         } 
                         completion:^(BOOL  completed){
                             if (completed) 
                                 expandView = 1;
                             shrinkView = 0;
                             [self replaceExistingValueAtIndex:indexValue];
                             [self animateSphereView:animateView];                  
                         }                   
         ];
    }
}

-(void)replaceExistingValueAtIndex:(int)index
{
    if(!runAnimation)
    {
        return;
    }
    NSLog(@"replaceExistingValueAtIndex animationArray = %@",animationArray);
    
    NSMutableDictionary *animationValues = [animationArray objectAtIndex:index];
    stopAnimation = [[animationValues objectForKey:@"stopAnimation"] intValue];
    
    animationDictionary = [[NSMutableDictionary alloc] init];
    
    [animationDictionary setObject:[NSString stringWithFormat:@"%d",stopAnimation] forKey:@"stopAnimation"];
    [animationDictionary setObject:[NSString stringWithFormat:@"%d",expandView] forKey:@"expandView"];
    [animationDictionary setObject:[NSString stringWithFormat:@"%d",shrinkView] forKey:@"shrinkView"];
    
    [animationArray replaceObjectAtIndex:index withObject:animationDictionary];
    
}

#pragma mark handling Tap Gesture

- (void)handleSingleTap:(UIGestureRecognizer *)gesture 
{
   /* int index = 0;
    NSString *value = [NSString stringWithFormat:@"%d",gesture.view.tag]; 
    if ([noDuplicates containsObject:value])
    {
        for (int loop = 0; loop<[noDuplicates count]; loop++) 
        {
            if([[noDuplicates objectAtIndex:loop] isEqual:value])
            {
                index = loop;
            }
        }
    }
    
    animationDictionary = [[NSMutableDictionary alloc] init];
    int dumpValue = 2;
    [animationDictionary setObject:[NSString stringWithFormat:@"%d",dumpValue] forKey:@"stopAnimation"];
    [animationDictionary setObject:[NSString stringWithFormat:@"%d",expandView] forKey:@"expandView"];
    [animationDictionary setObject:[NSString stringWithFormat:@"%d",shrinkView] forKey:@"shrinkView"];
    
    [animationArray replaceObjectAtIndex:index withObject:animationDictionary];
    
    NSMutableDictionary *animationValues = [animationArray objectAtIndex:index];
    stopAnimation = [[animationValues objectForKey:@"stopAnimation"] intValue];
    expandView = [[animationValues objectForKey:@"expandView"] intValue];
    shrinkView = [[animationValues objectForKey:@"shrinkView"] intValue];
    
    [[gesture.view superview].layer removeAllAnimations];*/
    
    BOOL iPad = NO;
    
    UIStoryboard *mainStoryboard = nil;
    
#ifdef UI_USER_INTERFACE_IDIOM
    iPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#endif
    if (iPad) 
    {
        mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle: nil];
        
        if(![popoverController isPopoverVisible])
        {
            acknowledgeViewController = (AcknowledgeViewController*)[mainStoryboard 
                                                                     instantiateViewControllerWithIdentifier:@"AcknowledgeViewController"];
            
            popoverController = [[UIPopoverController alloc] initWithContentViewController:acknowledgeViewController];
            
            [knowledgeDBViewController setRootPopUpViewController:popoverController];
            
            [popoverController setPopoverContentSize:CGSizeMake(300.0f, 400.0f)];
            
            [popoverController presentPopoverFromRect:gesture.view.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
        else
        {
            [popoverController dismissPopoverAnimated:YES];
        }
        
    } 
    else 
    {
        mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
        
        acknowledgeViewController = (AcknowledgeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"AcknowledgeViewController"];
        
        [self.view addSubview:acknowledgeViewController.view];
        
    }

}

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture 
{
    BOOL iPad = NO;
    
    UIStoryboard *mainStoryboard = nil;
    
#ifdef UI_USER_INTERFACE_IDIOM
    iPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#endif
    if (iPad) 
    {
        mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle: nil];
        
        if(![popoverController isPopoverVisible])
        {
            knowledgeDBViewController = (KnowledgeDBViewController*)[mainStoryboard 
                                            instantiateViewControllerWithIdentifier:@"KnowledgeDBViewController"];
            
            popoverController = [[UIPopoverController alloc] initWithContentViewController:knowledgeDBViewController];
            
            [knowledgeDBViewController setRootPopUpViewController:popoverController];
            
            [popoverController setPopoverContentSize:CGSizeMake(300.0f, 400.0f)];
            
            [popoverController presentPopoverFromRect:gesture.view.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
        else
        {
            [popoverController dismissPopoverAnimated:YES];
        }

    } 
    else 
    {
        mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
        
        knowledgeDBViewController = (KnowledgeDBViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"KnowledgeDBViewController"];
        
        [self.view addSubview:knowledgeDBViewController.view];

    }
}

#pragma mark Cancel Button Clicked

-(IBAction)cancelButtonClicked:(id)sender
{
    runAnimation = NO;
    appdelegate.tag = YES;
    textToDisplay = NO;
    [self retrieveDataInRegularInterval];
}

#pragma mark Loading Indicator

-(void)startLoadingIndicatorView:(NSString *)labelText
{
    if(!textToDisplay)
    {
        labelText = @"Closing View..";
    }
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
