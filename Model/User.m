//
//  User.m
//  ICDataflow
//
//  Created by Apple on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize ID;
@synthesize Name;
@synthesize FirstName;
@synthesize LastName;
@synthesize Username;

@synthesize PermissionID;
@synthesize UserID;
@synthesize PropertyID;
@synthesize LocationID;
@synthesize AccessLevel;

-(id)init
{
	if(self = [super init])
	{
    }
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder 
{
    [encoder encodeObject:self.ID forKey:@"ID"];
    [encoder encodeObject:self.Name forKey:@"Name"];
    [encoder encodeObject:self.FirstName forKey:@"FirstName"];
    [encoder encodeObject:self.LastName forKey:@"LastName"];
    [encoder encodeObject:self.Username forKey:@"Username"];
    
    [encoder encodeObject:self.PermissionID forKey:@"PermissionID"];
    [encoder encodeObject:self.UserID forKey:@"UserID"];
    [encoder encodeObject:self.PropertyID forKey:@"PropertyID"];
    [encoder encodeObject:self.LocationID forKey:@"LocationID"];
    [encoder encodeObject:self.AccessLevel forKey:@"AccessLevel"];

}

- (id)initWithCoder:(NSCoder *)decoder 
{
    if((self = [super init])) 
    {
        self.ID = [decoder decodeObjectForKey:@"ID"];
        self.Name = [decoder decodeObjectForKey:@"Name"];
        self.FirstName = [decoder decodeObjectForKey:@"FirstName"];        
        self.LastName = [decoder decodeObjectForKey:@"LastName"];
        self.Username = [decoder decodeObjectForKey:@"Username"];
        self.PermissionID = [decoder decodeObjectForKey:@"PermissionID"];
        self.UserID = [decoder decodeObjectForKey:@"UserID"];
        self.PropertyID = [decoder decodeObjectForKey:@"PropertyID"];
        self.LocationID = [decoder decodeObjectForKey:@"LocationID"];
        self.AccessLevel = [decoder decodeObjectForKey:@"AccessLevel"];
    }
    return self;
}

- (void)saveObject:(User *)obj 
{
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:myEncodedObject forKey:@"ReturnUser"];
}

- (User *)loadObjectWithKey:(NSString *)key 
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey:key];
    User *obj = (User *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    return obj;
}


@end
