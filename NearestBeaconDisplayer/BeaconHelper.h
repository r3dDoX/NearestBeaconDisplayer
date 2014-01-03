//
//  BeaconHelper.h
//  NearestBeaconDisplayer
//
//  Created by Patrick Walther on 30.11.13.
//  Copyright (c) 2013 WProduction. All rights reserved.
//

@import Foundation;
@import CoreLocation;

@interface BeaconHelper : NSObject {
    NSUUID *proximityUUID;
    CLBeaconMajorValue major;
    NSArray *knownRegions;
}

@property (nonatomic, readonly) NSUUID *proximityUUID;
@property (nonatomic, readonly) CLBeaconMajorValue major;
@property (nonatomic, readonly) NSArray *knownRegions;

+ (id)shared;

@end
