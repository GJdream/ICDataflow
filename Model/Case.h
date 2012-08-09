//
//  Case.h
//  ICDataflow
//
//  Created by Apple on 03/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Case : NSObject
{
    NSMutableString *CaseID;
    NSMutableString *CaseDateTime;
    NSMutableString *AlertID;
    NSMutableString *Notes;
    NSMutableString *Acknowledgements;
    
    NSMutableString *AlertMessage;
    NSMutableString *ThresholdName;
}

@property (strong, nonatomic) NSMutableString *CaseID;
@property (strong, nonatomic) NSMutableString *CaseDateTime;
@property (strong, nonatomic) NSMutableString *AlertID;
@property (strong, nonatomic) NSMutableString *Notes;
@property (strong, nonatomic) NSMutableString *Acknowledgements;

@property (strong, nonatomic) NSMutableString *AlertMessage;
@property (strong, nonatomic) NSMutableString *ThresholdName;

- (void)saveObject:(Case *)obj;
- (Case *)loadObjectWithKey:(NSString *)key;


@end
