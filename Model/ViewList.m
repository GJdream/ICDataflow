//
//  ViewList.m
//  ICDataflow
//
//  Created by Apple on 23/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewList.h"

@implementation ViewList

@synthesize viewList;

-(id)init
{
if(self = [super init])
{
    viewList = [[NSMutableArray alloc] init];
}
return self;
}

//-(void) dealloc
//{
//    [viewList  release];
//    [super dealloc];
//}


@end
