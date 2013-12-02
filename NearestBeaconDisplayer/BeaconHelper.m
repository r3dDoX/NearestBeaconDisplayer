//
//  BeaconHelper.m
//  NearestBeaconDisplayer
//
//  Created by Patrick Walther on 30.11.13.
//  Copyright (c) 2013 WProduction. All rights reserved.
//

#import "BeaconHelper.h"
#import "Beacon.h"

@implementation BeaconHelper

@synthesize proximityUUID;
@synthesize major;
@synthesize knownBeacons;

+ (id) shared {
    static BeaconHelper *beaconHelper = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        beaconHelper = [[self alloc] init];
    });
    
    return beaconHelper;
}

- (id) init {
    if (self = [super init]) {
        proximityUUID = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"]; // Estimote

        knownBeacons = [[NSMutableSet alloc] init];
        [knownBeacons addObject:[[Beacon alloc]
                                 initWithName:@"Mint"
                                 major:[NSNumber numberWithUnsignedShort: 34751]
                                 minor:[NSNumber numberWithUnsignedShort: 41649]]];
        [knownBeacons addObject:[[Beacon alloc]
                                 initWithName:@"Icy Marshmallow"
                                 major:[NSNumber numberWithUnsignedShort: 51881]
                                 minor:[NSNumber numberWithUnsignedShort: 16836]]];
        [knownBeacons addObject:[[Beacon alloc]
                                 initWithName:@"Blueberry Pie"
                                 major:[NSNumber numberWithUnsignedShort: 51681]
                                 minor:[NSNumber numberWithUnsignedShort: 23421]]];
    }
    return self;
}

@end
