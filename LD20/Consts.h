//
//  Consts.h
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Player.h"
#import "Util.h"


#define screenCenter_X [[Consts getInstance] screenCenter].x
#define screenCenter_Y [[Consts getInstance] screenCenter].y
#define SCREEN_WIDTH [[Consts getInstance] windowSize].width
#define SCREEN_HEIGHT [[Consts getInstance] windowSize].height
#define CANVAS [Consts getInstance].canvasLayer


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
static const int GUI_LABELS_Z = 10;

// time constraints
static const float CANNON_RELOAD_TIME = 0.28f;
static const float TOUCH_EVENTS_REPEAT_INTERVAL = 0.2f;

// spawn enemies
static const float SPAWN_NEXT_ENEMY_MIN_TIME_INTERVAL = 0.4f;
static const float SPAWN_NEXT_ENEMY_MAX_TIME_INTERVAL = 1.6f;
static const float ENEMY_SPEED = 0.35f;
static const float ENEMY_SPAWN_POS_Y_OFFSET = 50;

// enemy movement
static const float ENEMY_BEZIER_HORIZONTAL_SPAN = 200;
static const float ENEMY_BEZIER_CONTROL_POINT_1_Y = 300;
static const float ENEMY_BEZIER_CONTROL_POINT_2_Y = 100;
static const float ENEMY_BEZIER_CONTROL_POINT_VERTICAL_SPAN = 50;

// player
static const int PLAYER_START_POS_X = 100;
static const int PLAYER_START_POS_Y = 60;

// cheats
static const BOOL CHEAT_PLAYER_INVINCIBLE = NO;

// bullets
static const float BULLET_SPEED = 0.5f;
static const int BULLET_HIT_TAKES_HP = 34;

// results screen
static const int GAME_OVER_LBL_SIZE = 36;
static const int PLAYER_NAME_LBL_SIZE = 18;
static const int YOUR_SCORE_LBL_SIZE = 20;

static const int GAME_OVER_LBL_Y_OFFSET = 60;
static const int PLAYER_NAME_LBL_Y_OFFSET = 105;
static const int YOUR_SCORE_LBL_Y_OFFSET = 150;

static const int HIGHSCORES_TITLE_LBL_Y_OFFSET = 200;
static const int HIGHSCORES_TITLE_LBL_SIZE = 18;
static const int HIGHSCORES_TITLE_LIST_LBL_Y_OFFSET = 45;
static const int HIGHSCORES_LBL_VERTICAL_OFFSET = 30;
static const int HIGHSCORES_LBL_SIZE = 16;

static const int HIGHSCORE_LIST_LENGTH = 5;

// connection params
static const BOOL HTTP_CONNECTION_ENABLED = YES;
static const NSTimeInterval HTTP_CONNECTION_TIMEOUT = 60.0;
extern const NSString* DEFAULT_SERVER_ADDR;


// other
static const int SCORE_INCREMENT_VAL = 10;


@interface Consts : NSObject {
}

@property(nonatomic) CGPoint screenCenter;
@property(nonatomic) CGSize windowSize;
@property(nonatomic, retain) CCLayer* canvasLayer;

+ (Consts*)getInstance;

@end
