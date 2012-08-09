//
//  XmlParser.m
//  ICDataflow
//
//  Created by Apple on 23/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReturnViewsParser.h"

@implementation ReturnViewsParser

-(id)init:(NSData *)data  andTemp:(int)value
{
	if(self = [super init])
	{
        temp = value;
        
        if (gadget == nil) 
        {
            gadget = [[ Gadget alloc] init];
        }
        if(viewListObj == nil)
        {
            viewListObj = [[ViewList alloc] init];
        }
        if(thresholds == nil)
        {
            thresholds = [[Thresholds alloc] init];
        }
        if(cases == nil)
        {
            cases = [[Case alloc] init];
        }
        if(actionDatastream == nil)
        {
            actionDatastream = [[ActionDatastream alloc] init];
        }
        if (dataControllerObj == nil) 
        {
            dataControllerObj = [[DataController alloc] init];
        }
        
        currentElementValue = [[NSMutableString alloc] init];
        
        thresholdsObjArray = [[NSMutableArray alloc] init];
        
        thresholdContainerDict = [[NSMutableDictionary alloc] init];
        
        currentElement = nil;
        
        Gadgetdepth = 0;
        
        locationNamedepth = 0;
        
        ActionDatastreamdepth = 0;
        
        DisplayDatastreamdepth = 0;
        
        Colordepth = 0;
        
        viewsNamedepth = 0;
        
        Thresholdsdepth = 0; 
        
        noofthresholdsInCurGadget = 0;
        
        noofcasesInCurGadget = 0;
        
        NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];
        
        [nsXmlParser setDelegate:self];
        
        BOOL success = [nsXmlParser parse];
        
        if (success) 
        {
            NSLog(@"success");
            
//            if(temp == 0)
//            {
//                [gadget.GadgetNameArray addObject:@"sd"];  
//                [gadget.LocationNameArray addObject:@"ds"];  
//                [gadget.ActionDSValueArray addObject:@"0"];  
//                [gadget.DisplayDSValueArray addObject:@"3"];  
//
//                thresholds = [[Thresholds alloc] init];
//                thresholds.ID = [@"12" mutableCopy];;
//                thresholds.Name = [@"Viceroy" mutableCopy];
//                thresholds.Condition = [@""  mutableCopy];
//                thresholds.Operator = [@""  mutableCopy];
//                thresholds.Low = [@"0"  mutableCopy];
//                thresholds.High = [@"10"  mutableCopy] ;
//                thresholds.Color1 = [@"Green"  mutableCopy];
//                
//                depth++;
//                [gadget.thresholdArray addObject:thresholds];
//                
//                NSLog(@"noofthresholdsInCurGadget = %d",noofthresholdsInCurGadget);
//                NSLog(@"[gadget.thresholdArray count] = %d",[gadget.thresholdArray count]);
//
//                noofthresholdsInCurGadget = [gadget.thresholdArray count] - noofthresholdsInCurGadget;
//                [gadget.thresholdCountOnActionDS setObject:[NSString stringWithFormat:@"%d",noofthresholdsInCurGadget] forKey:[NSString stringWithFormat:@"%d",depth-1]];
//                noofthresholdsInCurGadget = [gadget.thresholdArray count];
//                
//                cases = [[Case alloc] init];
//                cases.CaseID = [@"12" mutableCopy];;
//                cases.CaseDateTime = [@"2012-06-06T09:31:45.477" mutableCopy];
//                cases.AlertID = [@""  mutableCopy];
//                cases.Notes = [@""  mutableCopy];
//                cases.Acknowledgements = [@""  mutableCopy];
//                cases.AlertMessage = [@""  mutableCopy] ;
//                cases.ThresholdName = [@"Threshold #1"  mutableCopy];
//                
//                [gadget.caseListArray addObject:cases];
//                
//                noofcasesInCurGadget = [gadget.caseListArray count] - noofcasesInCurGadget;
//                [gadget.caseCountOnActionDS setObject:[NSString stringWithFormat:@"%d",noofcasesInCurGadget] forKey:[NSString stringWithFormat:@"%d",depth-1]];
//                noofcasesInCurGadget = [gadget.caseListArray count];
//
//
//                temp = 0;
//            }
//            if(temp == 1)
//            {
//                [gadget.GadgetNameArray addObject:@"ds"];  
//                [gadget.LocationNameArray addObject:@"dsfaf"];  
//                [gadget.ActionDSValueArray addObject:@"0"];  
//                [gadget.DisplayDSValueArray addObject:@"4"];  
//                
//                thresholds = [[Thresholds alloc] init];
//                thresholds.ID = [@"12" mutableCopy];;
//                thresholds.Name = [@"2012-06-06T09:31:45.477" mutableCopy];
//                thresholds.Condition = [@""  mutableCopy];
//                thresholds.Operator = [@""  mutableCopy];
//                thresholds.Low = [@"10"  mutableCopy];
//                thresholds.High = [@"100"  mutableCopy] ;
//                thresholds.Color1 = [@"0"  mutableCopy];
//                
//                depth++;
//                [gadget.thresholdArray addObject:thresholds];
//
//                NSLog(@"noofthresholdsInCurGadget = %d",noofthresholdsInCurGadget);
//                NSLog(@"[gadget.thresholdArray count] = %d",[gadget.thresholdArray count]);
//
//                noofthresholdsInCurGadget = [gadget.thresholdArray count] - noofthresholdsInCurGadget;
//                [gadget.thresholdCountOnActionDS setObject:[NSString stringWithFormat:@"%d",noofthresholdsInCurGadget] forKey:[NSString stringWithFormat:@"%d",depth-1]];
//                noofthresholdsInCurGadget = [gadget.thresholdArray count];
//                
//                cases = [[Case alloc] init];
//                cases.CaseID = [@"12" mutableCopy];;
//                cases.CaseDateTime = [@"Viceroy" mutableCopy];
//                cases.AlertID = [@""  mutableCopy];
//                cases.Notes = [@""  mutableCopy];
//                cases.Acknowledgements = [@""  mutableCopy];
//                cases.AlertMessage = [@""  mutableCopy] ;
//                cases.ThresholdName = [@"Threshold #1"  mutableCopy];
//                
//                [gadget.caseListArray addObject:cases];
//                
//                noofcasesInCurGadget = [gadget.caseListArray count] - noofcasesInCurGadget;
//                [gadget.caseCountOnActionDS setObject:[NSString stringWithFormat:@"%d",noofcasesInCurGadget] forKey:[NSString stringWithFormat:@"%d",depth-1]];
//                noofcasesInCurGadget = [gadget.caseListArray count];
//
//
//                [gadget.GadgetNameArray addObject:@"ds1"];  
//                [gadget.LocationNameArray addObject:@"dsfaf1"];  
//                [gadget.ActionDSValueArray addObject:@"2"];  
//                [gadget.DisplayDSValueArray addObject:@"3"];  
//                
//                thresholds = [[Thresholds alloc] init];
//                thresholds.ID = [@"12" mutableCopy];;
//                thresholds.Name = [@"Viceroy" mutableCopy];
//                thresholds.Condition = [@""  mutableCopy];
//                thresholds.Operator = [@""  mutableCopy];
//                thresholds.Low = [@"10"  mutableCopy];
//                thresholds.High = [@"100"  mutableCopy] ;
//                thresholds.Color1 = [@"0"  mutableCopy];
//                
//                depth++;
//                [gadget.thresholdArray addObject:thresholds];
//                
//                NSLog(@"noofthresholdsInCurGadget = %d",noofthresholdsInCurGadget);
//                NSLog(@"[gadget.thresholdArray count] = %d",[gadget.thresholdArray count]);
//
//                noofthresholdsInCurGadget = [gadget.thresholdArray count] - noofthresholdsInCurGadget;
//                [gadget.thresholdCountOnActionDS setObject:[NSString stringWithFormat:@"%d",noofthresholdsInCurGadget] forKey:[NSString stringWithFormat:@"%d",depth-1]];
//                noofthresholdsInCurGadget = [gadget.thresholdArray count];
//                
//                cases = [[Case alloc] init];
//                cases.CaseID = [@"12" mutableCopy];;
//                cases.CaseDateTime = [@"2012-06-06T09:31:45.477" mutableCopy];
//                cases.AlertID = [@""  mutableCopy];
//                cases.Notes = [@""  mutableCopy];
//                cases.Acknowledgements = [@""  mutableCopy];
//                cases.AlertMessage = [@""  mutableCopy] ;
//                cases.ThresholdName = [@"Threshold #1"  mutableCopy];
//                
//                [gadget.caseListArray addObject:cases];
//
//                noofcasesInCurGadget = [gadget.caseListArray count] - noofcasesInCurGadget;
//                [gadget.caseCountOnActionDS setObject:[NSString stringWithFormat:@"%d",noofcasesInCurGadget] forKey:[NSString stringWithFormat:@"%d",depth-1]];
//                noofcasesInCurGadget = [gadget.caseListArray count];
//
//            }

            [dataControllerObj addObjectToGadgetList:gadget];
            [dataControllerObj addObjectToViewList:viewListObj];
            
//            NSLog(@"viewListObj = %@",viewListObj.viewList);
//            
//            NSLog(@"GadgetNameArray = %@",gadget.GadgetNameArray);
//            NSLog(@"GadgetNameArray = %@",gadget.LocationNameArray);
//            NSLog(@"GadgetNameArray = %@",gadget.ActionDSValueArray);
//            NSLog(@"GadgetNameArray = %@",gadget.DisplayDSValueArray);
//            NSLog(@"thresholdArray = %@",gadget.thresholdArray);
//            NSLog(@"caseListArray = %@",gadget.caseListArray);
//            NSLog(@"actionDataStreamList = %@",gadget.actionDataStreamList);

            for(int loop = 0;loop < [gadget.thresholdArray count]; loop++)
            {
                Thresholds *localthresholds = [gadget.thresholdArray objectAtIndex:loop];
                NSLog(@"thresholds = %@",localthresholds.Color1);
            }
            
//            for(int loop = 0;loop < [gadget.caseListArray count]; loop++)
//            {
//                Case *localcases = [gadget.caseListArray objectAtIndex:loop];
//                NSLog(@"localcases = %@",localcases.CaseID);
//            }
//            for(int loop = 0;loop < [gadget.actionDataStreamList count]; loop++)
//            {
//                ActionDatastream *localActionDatastream = [gadget.actionDataStreamList objectAtIndex:loop];
//                NSLog(@"localActionDatastream = %@",localActionDatastream.Value);
//            }

        }
        else 
        {
            NSLog(@"failed");
        }
    
    
    }
	return self;
}



#pragma NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict 
{
    currentElement = [elementName copy];
    
    if ([elementName isEqualToString:@"View"])
    {
        ++viewsNamedepth;
    }
    
    if ([elementName isEqualToString:@"Gadget"])
    {
        ++Gadgetdepth;
        depth++;
    }
    
    if ([currentElement isEqualToString:@"LocationName"])
    {
        ++locationNamedepth;
    }
    
    if ([elementName isEqualToString:@"ActionDatastream"])
    {
        ActionDatastreamdepth = 1;
        actionDatastream = [[ActionDatastream alloc] init];
    }
    if ([elementName isEqualToString:@"Description"]  && (ActionDatastreamdepth == 1))
    {
        descriptiondepth = 1;
    }

    
    if ([elementName isEqualToString:@"DisplayDatastream"])
    {
        ++DisplayDatastreamdepth;
    }
    if (([elementName isEqualToString:@"Thresholds"]) && (ActionDatastreamdepth == 1))
    {
        Thresholdsdepth ++;
    }
    if (([elementName isEqualToString:@"Threshold"]) && (ActionDatastreamdepth == 1))
    {
       thresholds = [[Thresholds alloc] init];
    }
    if (([elementName isEqualToString:@"OpenCases"]) && (ActionDatastreamdepth == 1))
    {
        
    }
    if (([elementName isEqualToString:@"Case"]) && (ActionDatastreamdepth == 1))
    {
        cases = [[Case alloc] init];
    }

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{
    if (([currentElement isEqualToString:@"Name"]) && (viewsNamedepth == 1))
    {
        ++viewsNamedepth;
        [viewListObj.viewList addObject:string];
    }

    if (([currentElement isEqualToString:@"Name"]) && (Gadgetdepth == 1))
    {
        ++Gadgetdepth;
        [gadget.GadgetNameArray addObject:string];
    }
    else if (([currentElement isEqualToString:@"LocationName"]) && (locationNamedepth == 1))
    {
        ++locationNamedepth;
        [gadget.LocationNameArray addObject:string];
    }
    else if (([currentElement isEqualToString:@"Value"]) && (ActionDatastreamdepth == 1))
    {
        [gadget.ActionDSValueArray addObject:string];
    }
    else if (([currentElement isEqualToString:@"Value"]) && (DisplayDatastreamdepth == 1))
    {
        [gadget.DisplayDSValueArray addObject:string];
    }
    

    //actionDatastream 
     if ([currentElement isEqualToString:@"ID"] && (ActionDatastreamdepth == 1) && (descriptiondepth == 0))
    {
        actionDatastream.ID = [string copy];
    }
    else if ([currentElement isEqualToString:@"Name"] && (ActionDatastreamdepth == 1) && (descriptiondepth == 0))
    {
        actionDatastream.Name = [string copy];
    }
    else if ([currentElement isEqualToString:@"LocationName"] && (ActionDatastreamdepth == 1))
    {
        actionDatastream.LocationName = [string copy];
    }
    else if ([currentElement isEqualToString:@"PropertyName"] && (ActionDatastreamdepth == 1))
    {
        actionDatastream.PropertyName = [string copy];
    }
    else if ([currentElement isEqualToString:@"Value"] && (ActionDatastreamdepth == 1))
    {
        actionDatastream.Value = [string copy];
    }

    
    
   //thresholds 
    else if ([currentElement isEqualToString:@"ID"] && (ActionDatastreamdepth == 1))
    {
        thresholds.ID = [string copy];
    }
    else if ([currentElement isEqualToString:@"Name"] && (ActionDatastreamdepth == 1))
    {
        thresholds.Name = [string copy];
    }
    else if ([currentElement isEqualToString:@"Condition"] && (ActionDatastreamdepth == 1))
    {
        thresholds.Condition = [string copy];
    }
    else if ([currentElement isEqualToString:@"Operator"] && (ActionDatastreamdepth == 1))
    {
        thresholds.Operator = [string copy];
    }
    else if ([currentElement isEqualToString:@"Low"] && (ActionDatastreamdepth == 1))
    {
        thresholds.Low = [string copy];
    }
    else if ([currentElement isEqualToString:@"High"] && (ActionDatastreamdepth == 1))
    {
        thresholds.High = [string copy];
    }
    else if ([currentElement isEqualToString:@"Color1"] && (ActionDatastreamdepth == 1))
    {
        thresholds.Color1 = [string copy];
    }
    
    //case
    else if ([currentElement isEqualToString:@"CaseID"] && (ActionDatastreamdepth == 1))
    {
        cases.CaseID = [string copy];
    }
    else if ([currentElement isEqualToString:@"CaseDateTime"] && (ActionDatastreamdepth == 1))
    {
        cases.CaseDateTime = [string copy];
    }
    else if ([currentElement isEqualToString:@"AlertID"] && (ActionDatastreamdepth == 1))
    {
        cases.AlertID = [string copy];
    }
    else if ([currentElement isEqualToString:@"Notes"] && (ActionDatastreamdepth == 1))
    {
        cases.Notes = [string copy];
    }
    else if ([currentElement isEqualToString:@"Acknowledgements"] && (ActionDatastreamdepth == 1))
    {
        cases.Acknowledgements = [string copy];
    }
    else if ([currentElement isEqualToString:@"AlertMessage"] && (ActionDatastreamdepth == 1))
    {
        cases.AlertMessage = [string copy];
    }
    else if ([currentElement isEqualToString:@"ThresholdName"] && (ActionDatastreamdepth == 1))
    {
        cases.ThresholdName = [string copy];
    }
}  

- (void)parser:(NSXMLParser *)parser  didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI  qualifiedName:(NSString *)qName 
{
    if ([elementName isEqualToString:@"View"]) 
    {
        viewsNamedepth = 0;
    }
    
    if ([elementName isEqualToString:@"Gadget"]) 
    {
        Gadgetdepth = 0;
        locationNamedepth = 0;
        if([gadget.GadgetNameArray count] > [gadget.DisplayDSValueArray count])
        {
            [gadget.DisplayDSValueArray addObject:@"0"];
        }
     
        if([gadget.GadgetNameArray count] > [gadget.actionDataStreamList count])
        {
            actionDatastream = [[ActionDatastream alloc] init];
            [gadget.actionDataStreamList addObject:actionDatastream];
        }   
        
//        if([gadget.GadgetNameArray count] > [gadget.thresholdArray count])
//        {
//            thresholds = [[Thresholds alloc] init];
//            [gadget.thresholdArray addObject:thresholds];
//        }   
//        if([gadget.GadgetNameArray count] > [gadget.caseListArray count])
//        {
//            cases = [[Case alloc] init];
//            [gadget.caseListArray addObject:cases];
//        }   

    }
    
    if ([elementName isEqualToString:@"ActionDatastream"]) 
    {
        ActionDatastreamdepth = 0;
        descriptiondepth = 0;
        [gadget.actionDataStreamList addObject:actionDatastream];
    }
    
    if ([elementName isEqualToString:@"DisplayDatastream"]) 
    {
        --DisplayDatastreamdepth;
    }
    
    if (([elementName isEqualToString:@"Thresholds"]) && (ActionDatastreamdepth == 1))
    {
        noofthresholdsInCurGadget = [gadget.thresholdArray count] - noofthresholdsInCurGadget;
        if(noofthresholdsInCurGadget == 0)
        {
            thresholds = [[Thresholds alloc] init];
            [gadget.thresholdArray addObject:thresholds];
            noofthresholdsInCurGadget ++;
        }
        [gadget.thresholdCountOnActionDS setObject:[NSString stringWithFormat:@"%d",noofthresholdsInCurGadget] forKey:[NSString stringWithFormat:@"%d",depth-1]];
        noofthresholdsInCurGadget = [gadget.thresholdArray count];
    }
    if (([elementName isEqualToString:@"Threshold"]) && (ActionDatastreamdepth == 1))
    {
        [gadget.thresholdArray addObject:thresholds];

    }
    if (([elementName isEqualToString:@"OpenCases"]) && (ActionDatastreamdepth == 1))
    {
        noofcasesInCurGadget = [gadget.caseListArray count] - noofcasesInCurGadget;
        if(noofcasesInCurGadget == 0)
        {
            cases = [[Case alloc] init];
            [gadget.caseListArray addObject:cases];
            noofcasesInCurGadget ++;
        }
        [gadget.caseCountOnActionDS setObject:[NSString stringWithFormat:@"%d",noofcasesInCurGadget] forKey:[NSString stringWithFormat:@"%d",depth-1]];
        noofcasesInCurGadget = [gadget.caseListArray count];
    }
    if (([elementName isEqualToString:@"Case"]) && (ActionDatastreamdepth == 1))
    {
        [gadget.caseListArray addObject:cases];

    }


    currentElementValue = nil;
}

#pragma mark Private methods

- (void)showCurrentDepth
{
    NSLog(@"Gadget depth: %d", Gadgetdepth);
}


@end
