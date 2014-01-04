//
//  BeaconHelper.m
//  NearestBeaconDisplayer
//
//  Created by Patrick Walther on 30.11.13.
//  Copyright (c) 2013 WProduction. All rights reserved.
//

#import "BeaconHelper.h"

@interface BeaconHelper()
@property (nonatomic, readwrite) NSUUID *proximityUUID;
@property (nonatomic, readwrite) CLBeaconMajorValue major;
@property (nonatomic, readwrite) NSArray *knownRegions;
@end

@implementation BeaconHelper

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
        self.proximityUUID = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"]; // Estimote

        self.knownRegions = [[NSArray alloc] initWithObjects:
                        [[CLBeaconRegion alloc] initWithProximityUUID: self.proximityUUID major:34751 minor:41649 identifier:@"Mint"],
                        [[CLBeaconRegion alloc] initWithProximityUUID: self.proximityUUID major:51881 minor:16836 identifier:@"Icy Marshmallow"],
                        [[CLBeaconRegion alloc] initWithProximityUUID: self.proximityUUID major:51681 minor:23421 identifier:@"Blueberry Pie"], nil];
    }
    return self;
}

@end
