//
//  Consts.h
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define screenCenter_X [[Consts getInstance] screenCenter].x
#define screenCenter_Y [[Consts getInstance] screenCenter].y

static const float BULLET_SPEED = 90;

// star layers velocities
static const float STAR_LAYER_2_SPEED = -60.0;
static const float STAR_LAYER_1_SPEED = -70.0;
static const float STAR_LAYER0_SPEED = -100.0;
static const float STAR_LAYER1_SPEED = -130.0;

static const BOOL ACCELEROMETER_ENABLED = YES;


@interface Consts : NSObject {
}

@property(nonatomic) CGPoint screenCenter;
@property(nonatomic) CGSize windowSize;

+ (Consts*)getInstance;

@end
