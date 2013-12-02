//
//  ViewController.m
//  NearestBeaconDisplayer
//
//  Created by Patrick Walther on 28.11.13.
//  Copyright (c) 2013 WProduction. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "BeaconHelper.h"
#import "Beacon.h"

@interface ViewController ()

@property (strong,nonatomic) CLLocationManager* locationManager;
@property (strong,nonatomic) CLBeaconRegion* region;

@end

@implementation ViewController {
    BeaconHelper *beaconHelper;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    appDelegate.viewController = self;

    beaconHelper = [BeaconHelper shared];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateUiForNearestBeacon:(CLBeacon*) beacon
{
    NSString* prefix = nil;
    if (beacon.proximity == CLProximityImmediate) {
        prefix = @"At ";
    }
    else if (beacon.proximity == CLProximityNear) {
        prefix = @"Near ";
    }
    else if (beacon.proximity == CLProximityFar) {
        prefix = @"Far from ";
    }

    if (prefix != nil) {
        Beacon *nearestBeacon = [beaconHelper.knownBeacons member:[[Beacon alloc] initWithMajor:beacon.major minor:beacon.minor]];

        if(nearestBeacon) {
            NSString* text = [NSString stringWithFormat:@"%@ %@", prefix, nearestBeacon.name];
            self.beaconLabel.text = text;
            self.distanceLabel.text = [NSString stringWithFormat:@"%.2f m", beacon.accuracy];
        }
    } else {
        [self resetDisplay];
    }
}

- (void) resetDisplay
{
    self.beaconLabel.text = @"Beacon";
    self.distanceLabel.text = @"Distance";
}

@end
