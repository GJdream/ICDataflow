//
//  WebServiceManager.m
//  MyFusedLogic
//
//  Created by photon on 04/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WebServiceManager.h"
#import "Reachability.h"

@implementation WebServiceManager

@synthesize serviceDelegate;
@synthesize loginServiceDelegate;
@synthesize ReturnUsersServiceDelegate;
@synthesize RefreshTimeDelegate;

- (id)init
{
	if (self = [super init]) {
	}
	return self;
}

-(void)WebserviceRequest:(NSString *)urlString andSOAPMsg:(NSString *)soapMsg andSOAPAction:(NSString *)soapAction
{
	if(recivedData != nil)
	{
		recivedData = nil;		
	}
	
	recivedData =[[NSMutableData alloc]init];
	
	if(urlString != nil)
	{
		done = NO;
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
        
        internetReach = [Reachability reachabilityForInternetConnection] ;
        [internetReach startNotifier];
        Reachability *curReach = [self updateInterfaceWithReachability: internetReach];
        
        NetworkStatus netStatus = [curReach currentReachabilityStatus];
        NSString* statusString= @"";
        switch (netStatus)
        {
            case NotReachable:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"No network connection available" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"ok", nil];
                [alert show];
                break;
            }
                
            case ReachableViaWWAN:
            {
                statusString = @"Reachable WWAN";
            }
            case ReachableViaWiFi:
            {
                statusString= @"Reachable WiFi";
                NSURL *url = [NSURL URLWithString:urlString];
                
                NSMutableURLRequest *req =[NSMutableURLRequest requestWithURL:url];
                
                [req addValue:@"text/xml; charset=utf-8"forHTTPHeaderField:@"Content-Type"];
                [req addValue:soapAction forHTTPHeaderField:@"SOAPAction"];
                [req addValue:[NSString stringWithFormat:@"%d", [soapMsg length]] forHTTPHeaderField:@"Content-Length"];
                [req setHTTPMethod:@"POST"];
                [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
                
                urlconnection = [[NSURLConnection alloc] initWithRequest: req delegate:self];

                break;
            }
        }
	}
}


-(void)cancelRequest
{
	if(urlconnection != nil)
	{
		[urlconnection cancel];
	}
}

#pragma mark NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	
}


- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSString *message = [NSString stringWithFormat:@"Error! %@ %@",
						 [error localizedDescription],
						 [error localizedFailureReason]];
	
	urlconnection = nil;
	
	if(self.serviceDelegate != nil)
	{
		[self.serviceDelegate webServicedFailedWithError:error message:message];
	}
    if(self.loginServiceDelegate != nil)
	{
		[self.loginServiceDelegate LoginwebServicedFailedWithError:error message:message];
	}
    if(self.ReturnUsersServiceDelegate != nil)
	{
		[self.ReturnUsersServiceDelegate ReturnUsersServicedFailedWithError:error message:message];
	}
    if(self.RefreshTimeDelegate != nil)
	{
		[self.RefreshTimeDelegate RefreshTimeServicedFailedWithError:error message:message];
	}

	done =YES;
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	if(recivedData != nil)
	{
		[recivedData appendData:data];
	}
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if(urlconnection != nil)
	{
		urlconnection = nil;
	}
		
	if(self.serviceDelegate != nil)
	{
		[self.serviceDelegate webServicedFinished:recivedData];
	}
    if(self.loginServiceDelegate != nil)
	{
		[self.loginServiceDelegate LoginwebServicedFinished:recivedData];
	}
    if(self.ReturnUsersServiceDelegate != nil)
	{
		[self.ReturnUsersServiceDelegate ReturnUsersServicedFinished:recivedData];
	}
    if(self.RefreshTimeDelegate != nil)
	{
		[self.RefreshTimeDelegate RefreshTimeServicedFinished:recivedData];
	}

	done = YES;
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark Reachability

//Called by Reachability whenever status changes.
//- (void) reachabilityChanged: (NSNotification* )note
//{
//	Reachability* curReach = [note object];
//	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
//	Reachability *curReach = [self updateInterfaceWithReachability: curReach];
//}

- (Reachability*) updateInterfaceWithReachability: (Reachability*) curReach
{
    return curReach;
}
- (void)dealloc {

	if(urlconnection != nil)
	{
	}
	
}

@end
