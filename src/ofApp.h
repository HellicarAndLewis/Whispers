#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "ofxEstimote.h"
#include "SoundPoint.h"
#include "ofxTween.h"

class ofApp : public ofxiOSApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
    
        void audioIn(float * input, int bufferSize, int nChannels);
        void audioOut( float * output, int bufferSize, int nChannels );
    
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
    vector<float> soundBuffer;
    view *newView;
    float x, y;
    
    const int sampleRate = 44100;
    const float duration = 2.0;
    const int N = duration * sampleRate;
    int recPos = 0;
    int playPos = 100;
    bool setupFinished = false;
    
    vector<SoundPoint*>* soundPoints;
    SoundPoint* selectedPoint;
    SoundPoint* cracklingFire;
    SoundPoint* music;
    SoundPoint* scary;
    
    float sonicBuffer[];
};



