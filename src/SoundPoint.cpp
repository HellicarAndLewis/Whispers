//
//  SoundPoint.cpp
//  estimoteTest
//
//  Created by James Bentley on 6/3/15.
//
//

#include "SoundPoint.h"

SoundPoint::SoundPoint() {
    player = new ofSoundPlayer();
}

bool SoundPoint::setup(string _soundLoc, ofVec2f _loc = ofVec2f(0, 0), float _muteDist = 0.0, float _minVol = 0.0, float _maxVol = 1.0, bool _triggered = false) {
    loc = _loc;
    muteDist = _muteDist;
    minVol = _minVol;
    maxVol = _maxVol;
    triggered = _triggered;
    bool loaded = loadSound(_soundLoc);
    return loaded;
}

void SoundPoint::setLoop(bool _loop) {
    player->setLoop(_loop);
}

void SoundPoint::play() {
    if(player->isLoaded() && !player->getIsPlaying()) player->play();
    //else cout << "SoundPoint::play(): Error sound is not loaded" << endl;
}

void SoundPoint::setPaused(bool _paused) {
    player->setPaused(_paused);
}

void SoundPoint::stop() {
    if(player->getIsPlaying()){
        player->stop();
        player->setPosition(0.0);
    }
    //else cout << "SoundPoint::stop(): Error Sound is not playing" << endl;
}

bool SoundPoint::loadSound(string soundLoc) {
    player->loadSound(soundLoc);
    if(player->isLoaded()) return true;
    else return false;
}

void SoundPoint::setVol(float _vol, bool clamp = true) {
    if(clamp) {
        _vol = (_vol < 0.0) ? 0.0 : _vol;
        _vol = (_vol > 1.0) ? 1.0 : _vol;
    }
    player->setVolume(_vol);
}

void SoundPoint::setVolAtPoint(float x, float y) {
    float dist = getDist(x, y);
    if(dist > muteDist && muteDist > 0.0) {
        if(!triggered) {
            setVol(0.0);
            return;
        } else {
            stop();
            return;
        }
    } else {
        if(!triggered) {
            float vol = ofxTween::map(dist, 0, muteDist, maxVol, minVol, true, easeQuad, ofxTween::easeIn);
            setVol(vol);
        } else {
            setVol(1.0);
            setLoop(false);
            play();
        }
    }
}

float SoundPoint::getDist(float x, float y) {
    return abs(ofDist(x, y, loc.x, loc.y));
}
ofVec2f SoundPoint::getLoc() {
    return loc;
}

void SoundPoint::setLoc(float x, float y) {
    loc.x = x;
    loc.y = y;
}

void SoundPoint::setLoc(ofVec2f _loc) {
    loc = _loc;
}

void SoundPoint::draw(ofRectangle rect) {
    ofPushStyle();
    ofPushMatrix();
    ofTranslate(ofMap(loc.x, rect.x, rect.x + rect.width, 0, ofGetWidth()), ofMap(loc.y, rect.y, rect.y + rect.height, 0, ofGetHeight()));
    ofFill();
    ofSetColor(0);
    ofCircle(0, 0, 10, 10);
    ofNoFill();
    float val = ofMap(muteDist, 0, 8, 0, ofGetWidth());
    ofCircle(0, 0, val);
    ofFill();
    if(player->getIsPlaying()) {
        ofPushMatrix();
        ofScale(0.5, 0.5);
        ofDrawBitmapString("vol: " + ofToString(player->getVolume()), -10, -20);
        ofPopMatrix();
        ofTriangle(10, 10, 10, 15, 15, 12.5);
    } else {
        ofRect(10, 10, 5, 5);
    }
    ofPopStyle();
    ofPopMatrix();
}

