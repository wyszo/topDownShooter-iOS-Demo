//
//  GameLayer.m
//  LD20
//
//  Created by tomek on 5/1/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


#import "GameLayer.h"
#import "StarLayer.h"
#import "CCTouchDispatcher.h"
#import "Consts.h"
#import "Player.h"
#import "BattlefieldManager.h"


NSString* LIVE_INDICATOR_SPRITE_FNAME = @"live.png";


@interface GameLayer() 
- (void)loadLevel;
@end


@implementation GameLayer

BOOL userTouchesScreen = NO;
CGPoint lastTapLocation;


#pragma mark - scene lifecycle 

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)setupScoreLabel {
    scoreLbl = [CCLabelTTF labelWithString:@"Score: 0" fontName:@"Marker Felt" fontSize:16];
    scoreLbl.position = ccp(160,16);
    [self addChild: scoreLbl z:GUI_LABELS_Z];
}

-(void)setupNameLabel {
    CCLabelTTF* nameLbl = [CCLabelTTF labelWithString:PLAYER_NAME fontName:@"Marker Felt" fontSize:14];
    nameLbl.position = ccp(260,16);
    [self addChild: nameLbl z:GUI_LABELS_Z];
}

- (CCSprite*)createLiveIndicatorSpriteOnLayer:(CCLayer*)layer withPos:(CGPoint)pos andZOrder:(int)zOrder {
    return [[Util getInstance] createRetainSpriteWithFName:LIVE_INDICATOR_SPRITE_FNAME onLayer:layer withPos:pos andZOrder:zOrder];
}

- (void)setupLiveIndicators {
    CGPoint liveIndicatorPos = CGPointMake(LIVE_INDICATOR_POS_X, LIVE_INDICATOR_POS_Y);
    liveIndicator = [self createLiveIndicatorSpriteOnLayer:self withPos:liveIndicatorPos andZOrder:LIVE_INDICATOR_ZORDER];
}

-(id) init
{
	if( (self=[super init])) {
        
        // setup canvas
        [Consts getInstance].canvasLayer = self;
        
        // setup labels
        [self setupScoreLabel];
        [self setupNameLabel];
        [self setupLiveIndicators];
        
        // register for notifications
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scoreUpdated) name:@"scoreUpdated" object:nil];
        
        // init variables
        starLayer = [[StarLayer alloc] initOnLayer:self];    
        battlefield = [[BattlefieldManager alloc] initOnLayer:self];
        [self loadLevel];        
        self.isTouchEnabled = YES;
        
        // enable accelerometer
        if (ACCELEROMETER_ENABLED) {
            self.isAccelerometerEnabled = YES;
            [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1/30];
        }
        
        // schedule update
        [self schedule:@selector(nextFrame:)];        
	}
	return self;
}

- (void) dealloc
{
    [liveIndicator release];
    [battlefield release];
	[super dealloc];
}

#pragma mark - gui elements

- (void)scoreUpdated {
    NSString* str = [NSString stringWithFormat:@"Score: %d", SCORE];
    [scoreLbl setString:str];    
}

#pragma mark - level lifecycle

-(void)loadLevel {
    
    [battlefield resetState];
}

/**
 * Krok czasu symulacji 
 */ 
-(void)nextFrame:(ccTime)deltaTime {

    [battlefield nextFrame:deltaTime];
    [starLayer animateStarsWithDeltaTime:deltaTime];
}


#pragma mark - accelerometer

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
    static float prevX = 0;
    float accelX = (float) acceleration.x;

        // 'wygaszenie' ruchów przy zmianie kierunków
        //#define kFilterFactor 0.05f
        //float accelX = (float) acceleration.x * kFilterFactor + (1-kFilterFactor)*prevX;
        
    prevX = accelX;
    
    float speed = -80 * -accelX;
    [battlefield.player moveWithSpeed:speed];
}


#pragma mark - touch dispatch

/**
 * Procedura obsługi tapnięć 
 */ 
- (void)userTappedAtPoint:(CGPoint)point {
    
    [battlefield userTappedAtPoint:point];
}

- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

// jeśli user dotyka ekranu, generuje powtórne tapnięcie 
- (void)userTapEventRepeat {
    if (userTouchesScreen) 
        [self userTappedAtPoint:lastTapLocation]; 
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [self convertTouchToNodeSpace:touch];
    [self userTappedAtPoint:location];
    lastTapLocation = location;
    userTouchesScreen = YES;
    
    [self schedule:@selector(userTapEventRepeat) interval:TOUCH_EVENTS_REPEAT_INTERVAL];
    
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    userTouchesScreen = NO;
    
    [self unschedule:@selector(userTapEventRepeat)];
}

@end
