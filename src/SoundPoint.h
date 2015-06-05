//
//  SoundPoint.h
//  estimoteTest
//
//  Created by James Bentley on 6/3/15.
//
//

#ifndef __estimoteTest__SoundPoint__
#define __estimoteTest__SoundPoint__

#include "ofMain.h"
#include "ofxTween.h"

class SoundPoint {
public:
    SoundPoint();
    bool setup(string _soundLoc, ofVec2f _loc, float muteDist, float minVol, float maxVol, bool _triggered);
    bool loadSound(string soundLoc);
    void setVol(float _vol, bool clamp);
    void setVolAtPoint(float x, float y);
    void setLoop(bool _loop);
    float getDist(float x, float y);
    ofVec2f getLoc();
    void setLoc(float x, float y);
    void setLoc(ofVec2f _loc);
    void play();
    void setPaused(bool _paused);
    void stop();
    void draw();
private:
    ofSoundPlayer* player;
    ofVec2f loc;
    float muteDist, minVol, maxVol;
    bool triggered;
    ofxEasingQuad easeQuad;
};

#endif /* defined(__estimoteTest__SoundPoint__) */
