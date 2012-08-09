//
//  ICDataflowAppDelegate.h
//  ICDataflow
//
//  Created by Apple on 30/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICDataflowAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableArray *acknowledgeArray;
    BOOL tag;
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic , retain) NSMutableArray *acknowledgeArray;
@property BOOL tag;

@end
