//
//  ViewController.h
//  NearestBeaconDisplayer
//
//  Created by Patrick Walther on 28.11.13.
//  Copyright (c) 2013 WProduction. All rights reserved.
//

@import UIKit;
@import CoreLocation;

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel* beaconLabel;
@property (weak, nonatomic) IBOutlet UILabel* distanceLabel;

- (void) updateUiForNearestBeacon:(NSMutableDictionary*) rangedBeaconsByRegion;

@end
