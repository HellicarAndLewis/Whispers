#include "Integratorf.h"


Integratorf::Integratorf(void)
{
	mass = 1;
	force = 0;
	vel = 0;
	damping = DAMPING;
	attraction = ATTRACTION;
}

Integratorf::Integratorf(float _val) {
	val = _val;
	mass = 1;
	force = 0;
	vel = 0;
	damping = DAMPING;
	attraction = ATTRACTION;
}

Integratorf::Integratorf(float _val, float _damping, float _attraction) {
	val = _val;
	damping = _damping;
	attraction = _attraction;
	mass = 1;
	force = 0;
	vel = 0;
}

void Integratorf::set(float _val) {
	val = _val;
}

void Integratorf::update() {
	if(targeting) {
		force += attraction * (tar - val);
	}
	acc = force / mass;
	vel = (vel + acc) * damping;
	val += vel;

	force = 0;
}

void Integratorf::target(float _tar) {
	targeting = true;
	tar = _tar;
}
	
void Integratorf::noTarget() {
	targeting = false;
}


Integratorf::~Integratorf(void)
{
}
