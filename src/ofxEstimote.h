//
//  ofxEstimote.h
//  estimoteTest
//
//  Created by James Bentley on 6/2/15.
//
//

#ifndef __estimoteTest__ofxEstimote__
#define __estimoteTest__ofxEstimote__

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "ESTIndoorLocationManager.h"
#include "ESTLocationBuilder.h"
#include "ESTLocation.h"
#include "ESTOrientedLineSegment.h"
#include "ESTConfig.h"

class estimoteLocation;

@interface view : NSObject<ESTIndoorLocationManagerDelegate>

@property (retain) ESTIndoorLocationManager *manager;
@property (assign) ofVec2f position;
@property (assign) int accuracy;
@property (assign) float orientation;
@property (assign) ofVec2f origin;
@property (assign) vector<ofVec2f> corners;
@property (assign) vector<ofVec2f> beacons;
@property (assign) ofRectangle boundingBox;
- (void) setup;
- (void) draw;

@end

class estimoteLocation {
    view *newView;
    ofVec2f pos;
    float orient;
    int accuracy;
};

#endif /* defined(__estimoteTest__ofxEstimote__) */
