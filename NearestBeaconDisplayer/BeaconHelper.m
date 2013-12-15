//
//  BeaconHelper.m
//  NearestBeaconDisplayer
//
//  Created by Patrick Walther on 30.11.13.
//  Copyright (c) 2013 WProduction. All rights reserved.
//

#import "BeaconHelper.h"

@implementation BeaconHelper

@synthesize proximityUUID;
@synthesize major;
@synthesize knownRegions;

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

        knownRegions = [[NSArray alloc] initWithObjects:
                        [[CLBeaconRegion alloc] initWithProximityUUID: proximityUUID major:34751 minor:41649 identifier:@"Mint"],
                        [[CLBeaconRegion alloc] initWithProximityUUID: proximityUUID major:51881 minor:16836 identifier:@"Icy Marshmallow"],
                        [[CLBeaconRegion alloc] initWithProximityUUID: proximityUUID major:51681 minor:23421 identifier:@"Blueberry Pie"], nil];
    }
    return self;
}

@end
