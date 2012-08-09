//
//  Gadget.h
//  ICDataflow
//
//  Created by Apple on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gadget : NSObject
{
    NSMutableArray *LocationNameArray;
    NSMutableArray *GadgetNameArray;
    NSMutableArray *ActionDSValueArray;
    NSMutableArray *DisplayDSValueArray;
    NSMutableArray *thresholdArray;
    NSMutableArray *caseListArray;
    NSMutableArray *actionDataStreamList;
    
    NSMutableDictionary *thresholdCountOnActionDS;
    NSMutableDictionary *caseCountOnActionDS;

}

@property (strong, nonatomic) NSMutableArray *GadgetNameArray;
@property (strong, nonatomic) NSMutableArray *LocationNameArray;
@property (strong, nonatomic) NSMutableArray *ActionDSValueArray;
@property (strong, nonatomic) NSMutableArray *DisplayDSValueArray;
@property (strong, nonatomic) NSMutableArray *thresholdArray;
@property (strong, nonatomic) NSMutableArray *caseListArray;
@property (strong, nonatomic) NSMutableArray *actionDataStreamList;

@property (strong, nonatomic) NSMutableDictionary *thresholdCountOnActionDS;
@property (strong, nonatomic) NSMutableDictionary *caseCountOnActionDS;

@end
