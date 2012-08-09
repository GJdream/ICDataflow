//
//  Thresholds.m
//  ICDataflow
//
//  Created by Apple on 03/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Thresholds.h"

@implementation Thresholds

@synthesize ID;
@synthesize Name;
@synthesize Condition;
@synthesize Operator;
@synthesize High;

@synthesize Low;
@synthesize Color1;

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
    [encoder encodeObject:self.Condition forKey:@"Condition"];
    [encoder encodeObject:self.Operator forKey:@"Operator"];
    [encoder encodeObject:self.High forKey:@"High"];
    
    [encoder encodeObject:self.Low forKey:@"Low"];
    [encoder encodeObject:self.Color1 forKey:@"Color1"];
    
}

- (id)initWithCoder:(NSCoder *)decoder 
{
    if((self = [super init])) 
    {
        self.ID = [decoder decodeObjectForKey:@"ID"];
        self.Name = [decoder decodeObjectForKey:@"Name"];
        self.Condition = [decoder decodeObjectForKey:@"Condition"];        
        self.Operator = [decoder decodeObjectForKey:@"Operator"];
        self.High = [decoder decodeObjectForKey:@"High"];
        self.Low = [decoder decodeObjectForKey:@"Low"];
        self.Color1 = [decoder decodeObjectForKey:@"Color1"];
    }
    return self;
}

- (void)saveObject:(Thresholds *)obj 
{
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:myEncodedObject forKey:@"Thresholds"];
}

- (Thresholds *)loadObjectWithKey:(NSString *)key 
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey:key];
    Thresholds *obj = (Thresholds *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    return obj;
}


@end
