//
//  estimoteDistanceManager.h
//  WhispersProximity
//
//  Created by James Bentley on 6/10/15.
//
//

#ifndef __WhispersProximity__estimoteDistanceManager__
#define __WhispersProximity__estimoteDistanceManager__

#include "ofMain.h"
//#import <UIKit/UIKit.h>
#import "ESTBeaconManager.h"
#import "ESTBeaconRegion.h"
//#import "ESTUtilityManager.h"
//#import "EstimoteSDK.h"
//#import <CoreLoaction/CoreLocation.h>

//class estimoteDistanceManager;

@interface estimoteDistanceManager : NSObject<ESTBeaconManagerDelegate>

@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion *beaconRegion;
//@property (nonatomic, strong) ESTUtilityManager *utilityManager;


@property (assign) map<int, double> distances;

- (void) setup;
//- (id) initWithScanType:(ESTScanType)scanType completion:(void (^)(id))completion;
@end


#endif /* defined(__WhispersProximity__estimoteDistanceManager__) */
