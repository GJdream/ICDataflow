//
//  ActionDatastream.h
//  ICDataflow
//
//  Created by Apple on 03/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionDatastream : NSObject
{
    NSMutableString *ID;
    NSMutableString *Name;
    NSMutableString *LocationName;
    NSMutableString *PropertyName;
    NSMutableString *Value;
}

@property (strong, nonatomic) NSMutableString *ID;
@property (strong, nonatomic) NSMutableString *Name;
@property (strong, nonatomic) NSMutableString *LocationName;
@property (strong, nonatomic) NSMutableString *PropertyName;
@property (strong, nonatomic) NSMutableString *Value;

- (void)saveObject:(ActionDatastream *)obj;
- (ActionDatastream *)loadObjectWithKey:(NSString *)key;

@end
