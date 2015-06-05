#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(161, 163, 148);
    [ESTConfig setupAppID:@"tol-whispers" andAppToken:@"7ca01170250aa7e7cb1f901d6b40b762"];
    
    cracklingFire = new SoundPoint();
    music = new SoundPoint();
    scary = new SoundPoint();
    
    soundPoints = new vector<SoundPoint*>();
    soundPoints->push_back(cracklingFire);
    soundPoints->push_back(music);
    selectedPoint = NULL;
    
    bool loaded = cracklingFire->setup("sounds/Fire.mp3", ofVec2f(0, 0), 4, 0.0, 1.0, false);
    
    if(loaded) {
        cracklingFire->setLoop(true);
        cracklingFire->play();
    }
    
    loaded = music->setup("sounds/music.mp3", ofVec2f(0, 0), 8, 0.0, 1.0, false);
    
    if(loaded) {
        music->setLoop(true);
        music->play();
    }
    
    newView = [[view alloc] init];
    
    [newView setup];
    
    ofSoundStreamSetup(2, 0);
    
    x = 0;
    y = 0;
}

//--------------------------------------------------------------
void ofApp::update(){
    x = [newView position].x;
    y = [newView position].y;
    for(auto point : *soundPoints) {
        point->setVolAtPoint(x, y);
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofSetColor(0);
    //ofDrawBitmapString("x: " + ofToString([newView position].x), 10, 10);
    //ofDrawBitmapString("y: " + ofToString([newView position].y), 10, 20);
    //ofDrawBitmapString("or: " + ofToString([newView orientation]), 10, 30);
    //ofDrawBitmapString("acc: " + ofToString([newView accuracy]), 10, 40);
    
    [newView draw];
    
    for(auto point : *soundPoints) {
        point->draw();
    }
    
    for(auto point : [newView corners]) {
        float x = ofMap(point.x, -4, 4, 0, ofGetWidth(), false);
        float y = ofMap(point.y, -4, 4, 0, ofGetHeight(), false);
        ofCircle(x, y, 5);
    }

    ofSetColor(255, 0, 0);
    ofCircle(ofMap(x, -4, 4, 0, ofGetWidth()), ofMap(y, -4, 4, 0, ofGetHeight()), 10);
}

void ofApp::audioOut( float * output, int bufferSize, int nChannels ) {
    
}


//--------------------------------------------------------------
void ofApp::exit(){
    
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    float minDist = 100000;
    for(auto point : *soundPoints) {
        float dist = point->getDist(ofMap(touch.x, 0, ofGetWidth(), -4, 4), ofMap(touch.y, 0, ofGetHeight(), -4, 4));
        if(dist < minDist && dist < 0.15) {
            minDist = dist;
            selectedPoint = point;
        }
    }
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    if(selectedPoint != NULL) {
        selectedPoint->setLoc(ofMap(touch.x, 0, ofGetWidth(), -4, 4), ofMap(touch.y, 0, ofGetHeight(), -4, 4));
    }
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    selectedPoint = NULL;
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    selectedPoint = NULL;
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}
