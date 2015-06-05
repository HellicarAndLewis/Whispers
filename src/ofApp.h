#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "ofxEstimote.h"
#include "SoundPoint.h"
#include "ofxTween.h"

class ofApp;

//@interface estimoteDelegate : NSObject<ESTIndoorLocationManagerDelegate> {
//    ofApp* appCpp;
//}
//
//- (id) init:(ofApp *)estCpp;
//
//@end

class ofApp : public ofxiOSApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
    
        void audioOut( float * output, int bufferSize, int nChannels );
    
       // void audioRequested(float * output, int bufferSize, int nChannels);
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
    ESTLocation *location;
    ESTIndoorLocationManager *manager;
    //ESTIndoorLocationView *view;
    view *newView;
    float x, y;
    
    //estimoteDelegate *delegate;
    
    //ofSoundStream stream;
    vector<SoundPoint*>* soundPoints;
    SoundPoint* selectedPoint;
    SoundPoint* cracklingFire;
    SoundPoint* music;
    SoundPoint* scary;
    //ofSoundPlayer player;
    //ofSoundPlayer player2;
    
    float sonicBuffer[];
};



