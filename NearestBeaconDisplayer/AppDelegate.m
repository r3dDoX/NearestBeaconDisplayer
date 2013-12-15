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
    CLLocationManager *locationManager;
    NSMutableDictionary *rangedBeaconsByRegion;
}

@synthesize viewController;

- (void) createLocationManager {
    beaconHelper = [BeaconHelper shared];
    rangedBeaconsByRegion = [[NSMutableDictionary alloc] init];

    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;

    for(CLBeaconRegion *region in beaconHelper.knownRegions) {
        region.notifyEntryStateOnDisplay = YES;
        region.notifyOnEntry = YES;
        region.notifyOnExit = YES;

        [locationManager startMonitoringForRegion: region];
        [locationManager startRangingBeaconsInRegion: region];
    }
}

#pragma mark methods from UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [locationManager stopMonitoringSignificantLocationChanges];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark methods from CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)enteredRegion
{
    NSMutableString *message = [[NSMutableString alloc] initWithString:@"You're near "];
    [message appendString:enteredRegion.identifier];

    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = message;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)exitedRegion
{
    [rangedBeaconsByRegion removeObjectForKey:exitedRegion];
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

    [rangedBeaconsByRegion setObject:[beacons objectAtIndex:0] forKey:region];

    [viewController updateUiForNearestBeacon:rangedBeaconsByRegion];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"Received updated location information");
}

@end
