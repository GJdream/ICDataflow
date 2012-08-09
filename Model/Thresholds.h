//
//  Thresholds.h
//  ICDataflow
//
//  Created by Apple on 03/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface Thresholds : NSObject
{
    NSMutableString *ID;
    NSMutableString *Name;
    NSMutableString *Condition;
    NSMutableString *Operator;
    NSMutableString *Low;
    
    NSMutableString *High;
    NSMutableString *Color1;
}

@property (strong, nonatomic) NSMutableString *ID;
@property (strong, nonatomic) NSMutableString *Name;
@property (strong, nonatomic) NSMutableString *Condition;
@property (strong, nonatomic) NSMutableString *Operator;
@property (strong, nonatomic) NSMutableString *Low;

@property (strong, nonatomic) NSMutableString *High;
@property (strong, nonatomic) NSMutableString *Color1;

- (void)saveObject:(Thresholds *)obj;
- (Thresholds *)loadObjectWithKey:(NSString *)key;

@end

