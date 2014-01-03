//
//  AppDelegate.h
//  NearestBeaconDisplayer
//
//  Created by Patrick Walther on 28.11.13.
//  Copyright (c) 2013 WProduction. All rights reserved.
//

@import UIKit;
@import CoreLocation;
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (weak,nonatomic) IBOutlet UILabel* delegateLabel;
@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) ViewController *viewController;

@end
