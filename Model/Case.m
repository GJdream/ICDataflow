//
//  Case.m
//  ICDataflow
//
//  Created by Apple on 03/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Case.h"

@implementation Case

@synthesize CaseID;
@synthesize CaseDateTime;
@synthesize AlertID;
@synthesize Notes;
@synthesize Acknowledgements;

@synthesize AlertMessage;
@synthesize ThresholdName;

-(id)init
{
	if(self = [super init])
	{
    }
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder 
{
    [encoder encodeObject:self.CaseID forKey:@"CaseID"];
    [encoder encodeObject:self.CaseDateTime forKey:@"CaseDateTime"];
    [encoder encodeObject:self.AlertID forKey:@"AlertID"];
    [encoder encodeObject:self.Notes forKey:@"Notes"];
    [encoder encodeObject:self.Acknowledgements forKey:@"Acknowledgements"];
    
    [encoder encodeObject:self.AlertMessage forKey:@"AlertMessage"];
    [encoder encodeObject:self.ThresholdName forKey:@"ThresholdName"];
    
}

- (id)initWithCoder:(NSCoder *)decoder 
{
    if((self = [super init])) 
    {
        self.CaseID = [decoder decodeObjectForKey:@"CaseID"];
        self.CaseDateTime = [decoder decodeObjectForKey:@"CaseDateTime"];
        self.AlertID = [decoder decodeObjectForKey:@"AlertID"];        
        self.Notes = [decoder decodeObjectForKey:@"Notes"];
        self.Acknowledgements = [decoder decodeObjectForKey:@"Acknowledgements"];
        self.AlertMessage = [decoder decodeObjectForKey:@"AlertMessage"];
        self.ThresholdName = [decoder decodeObjectForKey:@"ThresholdName"];
    }
    return self;
}

- (void)saveObject:(Case *)obj 
{
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:myEncodedObject forKey:@"Case"];
}

- (Case *)loadObjectWithKey:(NSString *)key 
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey:key];
    Case *obj = (Case *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    return obj;
}

@end
