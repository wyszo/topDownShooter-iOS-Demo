//
//  Consts.h
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

#define screenCenter_X [[Consts getInstance] screenCenter].x
#define screenCenter_Y [[Consts getInstance] screenCenter].y
#define SCREEN_WIDTH [[Consts getInstance] windowSize].width
#define SCREEN_HEIGHT [[Consts getInstance] windowSize].height
#define CANVAS [Consts getInstance].canvasLayer

static const float BULLET_SPEED = 0.9f;

// settings
static const BOOL ACCELEROMETER_ENABLED = YES;

// star layers velocities
static const float STAR_LAYER_2_SPEED = -60.0;
static const float STAR_LAYER_1_SPEED = -70.0;
static const float STAR_LAYER0_SPEED = -100.0;
static const float STAR_LAYER1_SPEED = -130.0;

// sprite ordering
static const int STAR_LAYER_Z = 0;
static const int PLAYER_BULLET_Z = 1;
static const int ENEMY_BULLET_Z = 2;
static const int ENEMY_SHIP_Z = 3;
static const int PLAYER_SHIP_Z = 4;

// time constraints
static const float CANNON_RELOAD_TIME = 0.26f;
static const float TOUCH_EVENTS_REPEAT_INTERVAL = 0.2f;

// spawn enemies
static const float SPAWN_NEXT_ENEMY_MIN_TIME_INTERVAL = 0.1f;
static const float SPAWN_NEXT_ENEMY_MAX_TIME_INTERVAL = 1.3f;
static const float ENEMY_SPEED = 0.35f;
static const float ENEMY_SPAWN_POS_Y_OFFSET = 50;

// other
static const int PLAYER_START_POS_X = 100;
static const int PLAYER_START_POS_Y = 60;


@interface Consts : NSObject {
}

@property(nonatomic) CGPoint screenCenter;
@property(nonatomic) CGSize windowSize;
@property(nonatomic, retain) CCLayer* canvasLayer;

+ (Consts*)getInstance;

@end
