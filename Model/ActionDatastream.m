//
//  ActionDatastream.m
//  ICDataflow
//
//  Created by Apple on 03/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActionDatastream.h"

@implementation ActionDatastream

@synthesize ID;
@synthesize Name;
@synthesize LocationName;
@synthesize PropertyName;
@synthesize Value;

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
    [encoder encodeObject:self.LocationName forKey:@"LocationName"];
    [encoder encodeObject:self.PropertyName forKey:@"PropertyName"];
    [encoder encodeObject:self.Value forKey:@"Value"];    
}

- (id)initWithCoder:(NSCoder *)decoder 
{
    if((self = [super init])) 
    {
        self.ID = [decoder decodeObjectForKey:@"ID"];
        self.Name = [decoder decodeObjectForKey:@"Name"];
        self.LocationName = [decoder decodeObjectForKey:@"LocationName"];        
        self.PropertyName = [decoder decodeObjectForKey:@"PropertyName"];
        self.Value = [decoder decodeObjectForKey:@"Value"];
    }
    return self;
}

- (void)saveObject:(ActionDatastream *)obj 
{
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:myEncodedObject forKey:@"ActionDatastream"];
}

- (ActionDatastream *)loadObjectWithKey:(NSString *)key 
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey:key];
    ActionDatastream *obj = (ActionDatastream *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    return obj;
}

@end
