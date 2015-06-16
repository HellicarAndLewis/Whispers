//
//  ofxEstimote.mm
//  estimoteTest
//
//  Created by James Bentley on 6/2/15.
//
//

#include "ofxEstimote.h"

@implementation view

- (void)setup {
    [super init];
    self.manager = [ESTIndoorLocationManager new];
    self.manager.delegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"location" ofType:@"json"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //ESTLocation *location = [ESTLocationBuilder parseFromJSON:content];
    ESTLocationBuilder *locationBuilder = [ESTLocationBuilder new];
    [locationBuilder setLocationBoundaryPoints:@[
                                                 [ESTPoint pointWithX:0 y:12.9],
                                                 [ESTPoint pointWithX:1.3 y:12.9],
                                                 [ESTPoint pointWithX:1.3 y:0],
                                                 [ESTPoint pointWithX:0 y:0]
                                                 ]];
    [locationBuilder setLocationOrientation:100];
    [locationBuilder addBeaconIdentifiedByMac:@"e207494c8945" atBoundarySegmentIndex:3 inDistance:0 fromSide:ESTLocationBuilderLeftSide];
    [locationBuilder addBeaconIdentifiedByMac:@"c59bbb8cae67" atBoundarySegmentIndex:1 inDistance:5 fromSide:ESTLocationBuilderLeftSide];
    [locationBuilder addBeaconIdentifiedByMac:@"ddc8e0e8c831" atBoundarySegmentIndex:3 inDistance:10 fromSide:ESTLocationBuilderRightSide];
    [locationBuilder addBeaconIdentifiedByMac:@"e9b2f2a78bb3" atBoundarySegmentIndex:1 inDistance:0 fromSide:ESTLocationBuilderLeftSide];
    
    ESTLocation *location = [locationBuilder build];
    
    [self.manager startIndoorLocation:location];
    self.origin = ofVec2f(location.boundingBox.origin.x, location.boundingBox.origin.y);
    for(id seg in [location boundarySegments]) {
        float x1 = [[seg point1] x];
        float y1 = [[seg point1] y];
        float x2 = [[seg point2] x];
        float y2 = [[seg point2] y];
        _corners.push_back(ofVec2f(x1, y1));
        _corners.push_back(ofVec2f(x2, y2));
    }
    CGRect tempBoundingBox = [location boundingBox];
    float width = tempBoundingBox.size.width;
    float height = tempBoundingBox.size.height;
    float originX = tempBoundingBox.origin.x;
    float originY = tempBoundingBox.origin.y;
    _boundingBox = ofRectangle(originX, originY, width, height);
    
//    for(id beacon in [location beacons]) {
//        ESTOrientedPoint *point = [beacon location];
//        NSString *name = [beacon macAddress];
//        float point = [beacon position]
//        float x = [point x];
//        float y = [point y];
//        ofVec2f loc = ofVec2f(x, y);
//        self.beacons.push_back(loc);
//    }
}

- (void)indoorLocationManager:(ESTIndoorLocationManager *)manager didUpdatePosition:(ESTOrientedPoint *)position withAccuracy:(ESTPositionAccuracy)positionAccuracy inLocation:(ESTLocation *)location
{
    self.position = ofVec2f(position.x, position.y);
    self.orientation = position.orientation;
    self.accuracy = positionAccuracy;
}

- (void)draw {
    float lastX;
    float lastY;
    bool first = true;
    ofPushStyle();
    ofSetLineWidth(5);
    for(auto corner : _corners) {
        float thisX = ofMap(corner.x, _boundingBox.x, _boundingBox.x + _boundingBox.width, 0, ofGetWidth());
        float thisY = ofMap(corner.y, _boundingBox.y, _boundingBox.y + _boundingBox.height, 0, ofGetHeight());
        if(!first) {
            ofLine(thisX, thisY, lastX, lastY);
        }
        lastX = thisX;
        lastY = thisY;
        first = false;
    }
    ofPopStyle();
}

- (void)indoorLocationManager:(ESTIndoorLocationManager *)manager didFailToUpdatePositionWithError:(NSError *)error
{    
    if (error.code == ESTIndoorPositionOutsideLocationError)
    {
        cout<<"It seems you are not in this location."<<endl;
    }
    else if (error.code == ESTIndoorMagnetometerInitializationError)
    {
        cout<<"It seems your magnetometer is not working."<<endl;
    }
    NSLog(@"%@", error.localizedDescription);
}
    
@end

