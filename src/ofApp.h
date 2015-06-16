#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "ofxEstimote.h"
#include "SoundPoint.h"
#include "ofxTween.h"
#include "estimoteDistanceManager.h"
#include "Integratorf.h"
#include "ofxGui.h"

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
    
    void onDelayChanged(float & delay);
    void onEchoChanged(float & echo);
    void applyEcho(float * output, int bufferSize, float echoDelay);
    
    ofxPanel gui;
    ofxSlider<float> delay;
    ofxSlider<float> echo;
    ofxSlider<float> lowVoice;
    
    ESTLocation *location;
    ESTIndoorLocationManager *manager;
    estimoteDistanceManager *distanceManager;
    vector<float> soundBuffer;
    view *locationView;
    Integratorf x, y;
    
    const int sampleRate = 44100;
    const float duration = 20.0;
    const int N = duration * sampleRate;
    int recPos = 0;
    int delayPos = 0;
    int echoPos = 0;
    int echoLength = sampleRate/2;
    bool setupFinished = false;
    
    vector<SoundPoint*>* soundPoints;
    SoundPoint* selectedPoint;
    SoundPoint* cracklingFire;
    SoundPoint* music;
    SoundPoint* scary;

    enum modes{
        LOCATION,
        PROXIMITY
    } mode;
};



