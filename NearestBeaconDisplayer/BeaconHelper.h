//
//  BeaconHelper.h
//  NearestBeaconDisplayer
//
//  Created by Patrick Walther on 30.11.13.
//  Copyright (c) 2013 WProduction. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BeaconHelper : NSObject {
    NSUUID *proximityUUID;
    CLBeaconMajorValue major;
    NSMutableSet *knownBeacons;
}

@property (nonatomic, readonly) NSUUID *proximityUUID;
@property (nonatomic, readonly) CLBeaconMajorValue major;
@property (nonatomic, readonly) NSMutableSet *knownBeacons;

+ (id)shared;

@end
