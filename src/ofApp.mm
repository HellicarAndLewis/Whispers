#include "ofApp.h"

#define MINBOUNDINGX [locationView boundingBox].x
#define MINBOUNDINGY [locationView boundingBox].y
#define BOUNDINGWIDTH [locationView boundingBox].width
#define BOUNDINGHEIGHT [locationView boundingBox].height

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(161, 163, 148);
    
    delay.addListener(this, &::ofApp::onDelayChanged);
    echo.addListener(this, &::ofApp::onEchoChanged);
    
    gui.setup("Background Effects");
//    gui.add(delay.setup("delay", 1.0, 0.1, duration - 0.1));
//    gui.add(echo.setup("echo", 3.0, 0.1, duration - 0.1));
    gui.add(echo.setup("echoLength", 0, 10000, 20000));

    
    [ESTConfig setupAppID:@"tol-whispers" andAppToken:@"7ca01170250aa7e7cb1f901d6b40b762"];
    
//    cracklingFire = new SoundPoint();
    music = new SoundPoint();
    x = Integratorf(0);
    y = Integratorf(0);
//    scary = new SoundPoint();
    
    soundPoints = new vector<SoundPoint*>();
    soundPoints->push_back(cracklingFire);
    soundPoints->push_back(music);
    soundPoints->push_back(scary);
    selectedPoint = NULL;
//
//    bool loaded = cracklingFire->setup("sounds/Fire.mp3", ofVec2f(0, 0), 2, 0.0, 1.0, false);
//    
//    if(loaded) {
//        cracklingFire->setLoop(true);
//        cracklingFire->play();
//    }
//    
//    loaded = music->setup("sounds/music.mp3", ofVec2f(0, 0), 3, 0.0, 1.0, false);
//    
//    if(loaded) {
//        music->setLoop(true);
//        music->play();
//    }
//    
//    loaded = scary->setup("sounds/horrorScream.mp3", ofVec2f(0, 0), 1, 0.0, 1.0, true);
//    
//    if(loaded) {
//        scary->setLoop(true);
//        scary->play();
//    }
//    
//    locationView = [[view alloc] init];
//    
//    [locationView setup];
//    
//    distanceManager = [[estimoteDistanceManager alloc] init];
//
//    [distanceManager setup];
//    
    ofSoundStreamSetup(2, 1);
    
    recPos = 0;
    delayPos = 0;
    echoPos = 0;
    echoLength = 2000;

    soundBuffer.resize(N, 0.0);
    setupFinished = true;
}
//--------------------------------------------------------------
void ofApp::audioIn(float * input, int bufferSize, int nChannels) {
    if (setupFinished) {
        for(int i = 0; i < bufferSize; i++) {
            soundBuffer[recPos] = input[i];
            recPos++;
            recPos %= N;
        }
    }
}


//--------------------------------------------------------------
void ofApp::update(){
//    x.target([locationView position].x);
//    y.target([locationView position].y);
//    for(auto point : *soundPoints) {
//        point->setVolAtPoint(x.val, y.val);
//    }
//    x.update();
//    y.update();
    cout<<"delayPos: "<<delayPos<<endl;
    cout<<"recPos: "<<recPos<<endl;
}

//--------------------------------------------------------------
void ofApp::draw(){
//    ofSetColor(0);
//    [locationView draw];
//    
//    for(auto point : *soundPoints) {
//        point->draw([locationView boundingBox]);
//    }
//    
//    for(auto point : [locationView corners]) {
//        float x = ofMap(point.x, MINBOUNDINGX, MINBOUNDINGX + BOUNDINGWIDTH, 0, ofGetWidth(), false);
//        float y = ofMap(point.y, MINBOUNDINGY, MINBOUNDINGY + BOUNDINGHEIGHT, 0, ofGetHeight(), false);
//        ofCircle(x, y, 5);
//    }
//
//    ofSetColor(255, 0, 0);
//    ofCircle(ofMap(x.val, MINBOUNDINGX, MINBOUNDINGX + BOUNDINGWIDTH, 0, ofGetWidth()), ofMap(y.val, MINBOUNDINGY, MINBOUNDINGY + BOUNDINGHEIGHT, 0, ofGetHeight()), 10);
    
    gui.draw();
}

void ofApp::audioOut( float * output, int bufferSize, int nChannels ) {
    if(setupFinished) {
        applyEcho(output, bufferSize, echo );

//        for(int i=0; i < bufferSize; i++) {
//            output[2*i] = output[2*i+1] = soundBuffer[delayPos];
//            delayPos++;
//            delayPos %= N;
//        }
    }
}

void ofApp::applyEcho(float * output, int bufferSize, float echoDelay) {
    for(int i=0; i < bufferSize; i++) {
        float percentage = 0.5;
        output[2*i] = output[2*i+1] = 0;
        for(int j=0; j < 5; j++) {
            output[2*i] = output[2*i+1] += soundBuffer[(int)(echoPos - echoDelay*j)%N]*percentage;
            percentage *= 0.5;
        };
        echoPos++;
        echoPos %= N;
    }
}


//--------------------------------------------------------------
void ofApp::exit(){
    soundBuffer.clear();
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
//    float minDist = 100000;
//    for(auto point : *soundPoints) {
//        float dist = point->getDist(ofMap(touch.x, 0, ofGetWidth(), MINBOUNDINGX, MINBOUNDINGX + BOUNDINGWIDTH), ofMap(touch.y, 0, ofGetHeight(), MINBOUNDINGY, MINBOUNDINGY + BOUNDINGHEIGHT));
//        if(dist < minDist && dist < 0.15) {
//            minDist = dist;
//            selectedPoint = point;
//        }
//    }
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
//    if(selectedPoint != NULL) {
//        selectedPoint->setLoc(ofMap(touch.x, 0, ofGetWidth(), MINBOUNDINGX, MINBOUNDINGX + BOUNDINGWIDTH), ofMap(touch.y, 0, ofGetHeight(), MINBOUNDINGY, MINBOUNDINGY + BOUNDINGHEIGHT));
//    }
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

    void exit();
//--------------------------------------------------------------
void ofApp::onDelayChanged(float & newDelay) {
    delayPos = recPos + (int)((duration-newDelay) * sampleRate);
    delayPos %= N;
}

//--------------------------------------------------------------
void ofApp::onEchoChanged(float & newEcho) {
    //echoPos = recPos + (int)((duration-newEcho) * sampleRate);
    //echoDuration = (int)((duration-newEcho) * sampleRate);
    //echoPos %= N;
}
