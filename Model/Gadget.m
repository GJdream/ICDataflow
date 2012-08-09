//
//  Gadget.m
//  ICDataflow
//
//  Created by Apple on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Gadget.h"

@implementation Gadget

@synthesize GadgetNameArray,LocationNameArray,ActionDSValueArray,DisplayDSValueArray,thresholdArray,caseListArray;

@synthesize actionDataStreamList;
@synthesize thresholdCountOnActionDS;
@synthesize caseCountOnActionDS;

-(id)init
{
	if(self = [super init])
	{
        LocationNameArray   = [[NSMutableArray alloc] init];
        GadgetNameArray     = [[NSMutableArray alloc] init];
        ActionDSValueArray  = [[NSMutableArray alloc] init];
        DisplayDSValueArray = [[NSMutableArray alloc] init];
        thresholdArray     = [[NSMutableArray alloc] init];	
        caseListArray = [[NSMutableArray alloc] init];	
        actionDataStreamList = [[NSMutableArray alloc] init];	
        thresholdCountOnActionDS = [[NSMutableDictionary alloc] init];	
        caseCountOnActionDS = [[NSMutableDictionary alloc] init];	

    }
	return self;
}
//
//-(void) dealloc
//{
//	[GadgetNameArray  release];
//	[LocationNameArray release];
//    [ActionDSValueArray release];
//    [DisplayDSValueArray release];
//	[colorValueArray release];
//    [super dealloc];
//}

@end
