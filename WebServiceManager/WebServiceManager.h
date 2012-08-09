//
//  WebServiceManager.h
//  MyFusedLogic
//
//  Created by photon on 04/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"


@protocol WebServiceManagerDelegate <NSObject>
@required
-(void)webServicedFinished:(NSData *)data;
-(void)webServicedFailedWithError:(NSError *)error message:(NSString *)message;
@end

@protocol LoginWebServiceManagerDelegate <NSObject>
@required
-(void)LoginwebServicedFinished:(NSData *)data;
-(void)LoginwebServicedFailedWithError:(NSError *)error message:(NSString *)message;
@end

@protocol ReturnUsersServiceManagerDelegate <NSObject>
@required
-(void)ReturnUsersServicedFinished:(NSData *)data;
-(void)ReturnUsersServicedFailedWithError:(NSError *)error message:(NSString *)message;
@end

@protocol RefreshTimeInSecondsDelegate <NSObject>
@required
-(void)RefreshTimeServicedFinished:(NSData *)data;
-(void)RefreshTimeServicedFailedWithError:(NSError *)error message:(NSString *)message;
@end

@interface WebServiceManager : NSObject
{
    
	NSURLConnection    *urlconnection;
	id				 	serviceDelegate;
    id				 	loginServiceDelegate;
	NSMutableData      *recivedData;
	BOOL done;
    Reachability* internetReach;

}

@property(nonatomic,retain) id <WebServiceManagerDelegate> serviceDelegate;
@property(nonatomic,retain) id <LoginWebServiceManagerDelegate> loginServiceDelegate;
@property(nonatomic,retain) id <ReturnUsersServiceManagerDelegate> ReturnUsersServiceDelegate;
@property(nonatomic,retain) id <RefreshTimeInSecondsDelegate> RefreshTimeDelegate;


-(id)init;
-(void)WebserviceRequest:(NSString *)urlString andSOAPMsg:(NSString *)soapMsg andSOAPAction:(NSString *)soapAction;
-(void)cancelRequest;
@end
