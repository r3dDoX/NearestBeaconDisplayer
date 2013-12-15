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

- (void) updateUiForNearestBeacon:(NSMutableDictionary*) rangedBeaconsByRegion
{
    CLBeaconRegion *region = [self getNearestBeaconRegion: rangedBeaconsByRegion];
    CLBeacon *beacon = [rangedBeaconsByRegion objectForKey:region];

    NSString* prefix = nil;
    switch (beacon.proximity) {
        case CLProximityImmediate:
            prefix = @"At ";
            break;
        case CLProximityNear:
            prefix = @"Near ";
            break;
        case CLProximityFar:
            prefix = @"Far from ";
            break;
        case CLProximityUnknown:
            prefix = @"Unknown proximity to ";
            break;
    }

    if (prefix != nil) {
        NSString* text = [NSString stringWithFormat:@"%@ %@", prefix, region.identifier];
        self.beaconLabel.text = text;
        self.distanceLabel.text = [NSString stringWithFormat:@"%.2f m", beacon.accuracy];
    } else {
        [self resetDisplay];
    }
}

- (CLBeaconRegion*) getNearestBeaconRegion: (NSMutableDictionary*) rangedBeaconsByRegion {
    double accuracy = INFINITY;
    CLBeaconRegion *nearestRegion = nil;

    for(CLBeaconRegion *region in rangedBeaconsByRegion) {
        CLBeacon *beacon = [rangedBeaconsByRegion objectForKey:region];
        if(beacon.accuracy < accuracy) {
            accuracy = beacon.accuracy;
            nearestRegion = region;
        }
    }

    return nearestRegion;
}

- (void) resetDisplay
{
    self.beaconLabel.text = @"Beacon";
    self.distanceLabel.text = @"Distance";
}

@end
