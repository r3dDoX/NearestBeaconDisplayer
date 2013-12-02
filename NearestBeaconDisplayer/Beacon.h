//
//  Beacon.h
//  NearestBeaconDisplayer
//
//  Created by Patrick Walther on 30.11.13.
//  Copyright (c) 2013 WProduction. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Beacon : NSObject {
    NSString *name;
    NSNumber *major;
    NSNumber *minor;
}

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSNumber *major;
@property (nonatomic, readonly) NSNumber *minor;

-(id) initWithName: (NSString*)theName major: (NSNumber*)majorId minor: (NSNumber*)minorId;
-(id) initWithMajor: (NSNumber*)majorId minor: (NSNumber*)minorId;

@end
