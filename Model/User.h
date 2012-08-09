//
//  User.h
//  ICDataflow
//
//  Created by Apple on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    NSMutableString *ID;
    NSMutableString *Name;
    NSMutableString *FirstName;
    NSMutableString *LastName;
    NSMutableString *Username;
    
    NSMutableString *PermissionID;
    NSMutableString *UserID;
    NSMutableString *PropertyID;
    NSMutableString *LocationID;
    NSMutableString *AccessLevel;

}

@property (strong, nonatomic) NSMutableString *ID;
@property (strong, nonatomic) NSMutableString *Name;
@property (strong, nonatomic) NSMutableString *FirstName;
@property (strong, nonatomic) NSMutableString *LastName;
@property (strong, nonatomic) NSMutableString *Username;

@property (strong, nonatomic) NSMutableString *PermissionID;
@property (strong, nonatomic) NSMutableString *UserID;
@property (strong, nonatomic) NSMutableString *PropertyID;
@property (strong, nonatomic) NSMutableString *LocationID;
@property (strong, nonatomic) NSMutableString *AccessLevel;

- (void)saveObject:(User *)obj;
- (User *)loadObjectWithKey:(NSString *)key;
@end
