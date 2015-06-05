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
    ESTLocation *location = [ESTLocationBuilder parseFromJSON:content];
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
        float thisX = ofMap(corner.x, -4, 4, 0, ofGetWidth());
        float thisY = ofMap(corner.y, -4, 4, 0, ofGetHeight());
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

