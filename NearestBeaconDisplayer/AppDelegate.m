//
//  AppDelegate.m
//  NearestBeaconDisplayer
//
//  Created by Patrick Walther on 28.11.13.
//  Copyright (c) 2013 WProduction. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BeaconHelper.h"

@implementation AppDelegate {
    BeaconHelper *beaconHelper;
    CLLocationManager* locationManager;
    CLBeaconRegion* region;
}

@synthesize viewController;

- (void) createLocationManager {
    beaconHelper = [BeaconHelper shared];

    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;

    region = [[CLBeaconRegion alloc]
              initWithProximityUUID: beaconHelper.proximityUUID
              identifier:@"TestRegion"];

    region.notifyEntryStateOnDisplay = NO;
    region.notifyOnEntry = YES;
    region.notifyOnExit = YES;

    [locationManager startMonitoringForRegion: region];
    [locationManager startRangingBeaconsInRegion: region];
}

- (NSArray*) sortBeacons:(NSArray*)beacons
{
    return [beacons sortedArrayUsingComparator:^(id obj1, id obj2) {
        CLBeacon* beacon1 = (CLBeacon*)obj1;
        CLBeacon* beacon2 = (CLBeacon*)obj2;

        if (beacon1.accuracy < beacon2.accuracy) {
            return (NSComparisonResult)NSOrderedAscending;
        } else if (beacon1.accuracy > beacon2.accuracy) {
            return (NSComparisonResult)NSOrderedDescending;
        } else {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
}

#pragma mark methods from UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"Application did finish launching with options");

    if([launchOptions objectForKey:@"UIApplicationLaunchOptionsLocationKey"]) {
        NSLog(@"Started with Location Key");
    }

    if (locationManager == nil) [self createLocationManager];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [locationManager startMonitoringSignificantLocationChanges];
    NSLog(@"Application did enter background");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [locationManager stopMonitoringSignificantLocationChanges];
    NSLog(@"Application did become active");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark methods from CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)enteredRegion
{
    NSLog(@"did enter region %@", enteredRegion);
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)exitedRegion
{
    NSLog(@"did exit region %@", exitedRegion);
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)regionWithError withError:(NSError *)error
{
    NSLog(@"monitoring did fail for region %@, with error %@", regionWithError, [error localizedDescription]);
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)regionWithState
{
    if(state == CLRegionStateInside)
    {
        NSLog(@"You're inside the region %@", regionWithState);
    }
    else if(state == CLRegionStateOutside)
    {
        NSLog(@"You're outside the region %@", regionWithState);
    }
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    // CoreLocation will call this delegate method at 1 Hz with updated range information.
    // Beacons will be categorized and displayed by proximity.
    if ([beacons count] == 0) {
        return;
    }

    NSArray* sortedBeacons = [self sortBeacons:beacons];
    [viewController updateUiForNearestBeacon: [sortedBeacons objectAtIndex:0]];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"Received updated location information");
}

@end
