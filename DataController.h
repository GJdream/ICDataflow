//
//  DataController.h
//  Timesly
//
//  Created by karthik keyan on 09/07/12.
//  Copyright (c) 2012 Mad Development Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gadget.h"
#import "ViewList.h"

@interface DataController : NSObject 
{
    NSMutableArray     *GadgetList;
    NSMutableArray     *ViewListArray;
}

@property (nonatomic, retain)   NSMutableArray     *GadgetList;
@property (nonatomic, retain)   NSMutableArray     *ViewListArray;

+(id)DataControllerObject;

- (void)addObjectToGadgetList:(Gadget *)GadgetObject;
- (void)releaseGadgetList;

- (void)addObjectToViewList:(ViewList *)ViewListObject;
- (void)releaseViewList;

-(void) deallocdatacontroller;
@end
