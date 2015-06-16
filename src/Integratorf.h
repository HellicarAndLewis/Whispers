#pragma once

#include "ofMain.h"

#define DAMPING 0.5f
#define ATTRACTION 0.2f

class Integratorf
{
public:
	Integratorf(void);
	Integratorf(float _val);
	Integratorf(float _val, float _damping, float _attraction);
	void set(float _val);
	void update();
	void target(float _tar);
	void noTarget();
	~Integratorf(void);

	float val;
	float vel;
	float acc;
	float force;
	float tar;
	float mass;

	float damping;
	float attraction;
	bool targeting;

};

