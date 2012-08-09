//
//  XmlParser.h
//  ICDataflow
//
//  Created by Apple on 23/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gadget.h"
#import "DataController.h"
#import "ViewList.h"
#import "Thresholds.h"
#import "Case.h"
#import "ActionDatastream.h"

@interface ReturnViewsParser : NSObject<NSXMLParserDelegate>
{
    NSInteger Gadgetdepth;
    NSInteger ActionDatastreamdepth;
    NSInteger DisplayDatastreamdepth;
    NSInteger Colordepth;
    NSInteger locationNamedepth;
    NSInteger viewsNamedepth;
    NSInteger Thresholdsdepth;
    NSInteger descriptiondepth;
    
    NSMutableArray *thresholdsObjArray;
    NSMutableDictionary *thresholdContainerDict;
    
    NSMutableString *currentElementValue;
    NSString *currentElement;
    
    Gadget *gadget;
    ViewList *viewListObj;
    Thresholds *thresholds;
    Case *cases;
    ActionDatastream *actionDatastream;
    DataController *dataControllerObj;
    
    
    int temp;
    int depth;
    int noofthresholdsInCurGadget;
    int noofcasesInCurGadget;
}

-(id)init:(NSData *)data andTemp:(int)value;

@end
