//
//  DataController.m
//  Timesly
//
//  Created by karthik keyan on 09/07/12.
//  Copyright (c) 2012 Mad Development Co. All rights reserved.
//

#import "DataController.h"

@implementation DataController

@synthesize GadgetList;
@synthesize ViewListArray;

static DataController *sharedInst = nil;

+ (id)DataControllerObject
{
    @synchronized( self ) 
	{
        if ( sharedInst == nil ) 
		{
            sharedInst = [[self alloc] init];
			
		}
    }
    return sharedInst;
}

- (id)init
{
    if ( sharedInst != nil ) 
	{
	}
	else if ( self = [super init] ) 
	{
        sharedInst		= self;
		
	}
	
    return sharedInst;
}

- (void)addObjectToGadgetList:(Gadget *)GadgetObject{
   
    if (GadgetList==nil) {
        
       GadgetList = [[NSMutableArray alloc]init];
    }
   
    [GadgetList addObject:GadgetObject];
        
}

- (void)releaseGadgetList{
   
    if (GadgetList!=nil && [GadgetList count] > 0) {
        
       GadgetList=nil; 
    }
    
}

- (void)addObjectToViewList:(ViewList *)ViewListObject
{
    if (ViewListArray==nil) {
        
        ViewListArray = [[NSMutableArray alloc]init];
    }
    
    [ViewListArray addObject:ViewListObject];

}
- (void)releaseViewList
{
    if (ViewListArray!=nil && [ViewListArray count] > 0) {
        
        ViewListArray=nil; 
    }
}

-(void) deallocdatacontroller
{
    sharedInst = nil;
}


@end
