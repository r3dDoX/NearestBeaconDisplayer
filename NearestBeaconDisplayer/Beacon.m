//
//  Beacon.m
//  NearestBeaconDisplayer
//
//  Created by Patrick Walther on 30.11.13.
//  Copyright (c) 2013 WProduction. All rights reserved.
//

#import "Beacon.h"

@implementation Beacon

@synthesize name;
@synthesize major;
@synthesize minor;

-(id) initWithName:(NSString*)theName major:(NSNumber*)majorId minor:(NSNumber*)minorId {
    self = [super init];
    
    if (self) {
        name = theName;
        major = majorId;
        minor = minorId;
    }

    return self;
}

-(id) initWithMajor: (NSNumber*)majorId minor: (NSNumber*)minorId;
{
    self = [super init];

    if (self) {
        name = @"";
        major = majorId;
        minor = minorId;
    }

    return self;
}

- (BOOL)isEqual:(id)other {
    if([other isKindOfClass:[self class]]) {
        Beacon *otherBeacon = (Beacon*) other;
        if([major longValue] == [otherBeacon.major longValue] && [minor longValue] == [otherBeacon.minor longValue]) {
            return YES;
        }
    }
    return NO;
}

- (NSUInteger)hash {
    NSUInteger hash = 0;
    
    hash += [[self major] hash];
    hash += [[self minor] hash];

    return hash;
}

@end
