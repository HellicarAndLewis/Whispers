//
//  estimoteDistanceManager.cpp
//  WhispersProximity
//
//  Created by James Bentley on 6/10/15.
//
//

#include "estimoteDistanceManager.h"

@implementation estimoteDistanceManager

- (void) setup
{
    [super init];
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID
                                                     identifier:@"EstimoteSampleRegion"];
    
    //[self startRangingBeacons];
    //[self.beaconManager requestAlwaysAuthorization];
    [self.beaconManager startEstimoteBeaconsDiscoveryForRegion:self.beaconRegion];
    //[self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void) beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region {
    self.distances.clear();
    for(id beacon in beacons) {
        int val = [[beacon major] intValue];
        double dist = [beacon accuracy];
        self.distances[val] = dist;
    }
}

-(void) beaconManager:(ESTBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    //[self.beaconManager requestAlwaysAuthorization];
    [self.beaconManager startRangingBeaconsInRegion:region];
    [self.beaconManager stopEstimoteBeaconDiscovery];

}

-(void) beaconManager:(id)manager rangingBeaconsDidFailForRegion:(ESTBeaconRegion *)region withError:(NSError *)error {
    cout<<error<<endl;
    cout << "Failed to range!" << endl;
}
    
-(void) beaconManager:(id)manager didStartMonitoringForRegion:(ESTBeaconRegion *)region {
    cout <<"monitoring for region started"<<endl;
}

-(void) beaconManager:(id)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    cout << "Authorization status changed to " << status<< endl;
    //[self.beaconManager startRangingBeaconsInRegion:_beaconRegion];
}

-(void)startRangingBeacons
{
    if ([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        [self.beaconManager requestAlwaysAuthorization];
        [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
    }
    else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)
    {
        [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
    }
    else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Access Denied"
                                                        message:@"You have denied access to location services. Change this in app settings."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        
        [alert show];
    }
    else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusRestricted)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Not Available"
                                                        message:@"You have no access to location services."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        
        [alert show];
    }
}
@end

