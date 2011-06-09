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


@interface GameLayer() 
- (void)loadLevel;
@end


@implementation GameLayer

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

- (void)addSampleLabelToLayer:(CCLayer*)layer {
    // ask director the the window size
    // CGSize size = [[CCDirector sharedDirector] winSize];
    
    // create and initialize a Label
    //		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
    
    // position the label on the center of the screen
    //		label.position =  ccp( size.width /2 , size.height/2 );
    
    // add the label as a child to this Layer
    //		[self addChild: label];
}


-(id) init
{
	if( (self=[super init])) {
        
        // sample label
        [self addSampleLabelToLayer:self];
        
        // init variables
        starLayer = [[StarLayer alloc] initOnLayer:self];    
        player = [[Player alloc] initOnLayer:self];
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
    [player release];
    [bullet release];
    [ufok1 release];
	[super dealloc];
}

-(void)loadLevel {
    
    [player resetState];
    
    // bullet
    bullet = [[CCSprite spriteWithFile:@"bullet.png"] retain];
    bullet.position = CGPointMake(200, 100);
    bullet.scale = 0.5;
    [self addChild:bullet];
    
    // enemy 
    ufok1 = [[CCSprite spriteWithFile:@"ufok1.png"] retain];
    ufok1.position = CGPointMake(200, 300);
    ufok1.scale = 0.5;
    [self addChild:ufok1];
}

/**
 * Krok czasu symulacji 
 */ 
-(void)nextFrame:(ccTime)deltaTime {
    // bullets
    bullet.position = CGPointMake(bullet.position.x, bullet.position.y + BULLET_SPEED * deltaTime);
    
    // stars 
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
    [player moveWithSpeed:speed];
}


#pragma mark - touch dispatch

/**
 * Procedura obsługi tapnięć 
 */ 
- (void)userTappedAtPoint:(CGPoint)point {
    [bullet stopAllActions];
    [bullet runAction:[CCMoveTo actionWithDuration:1 position:point]];
}

- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [self convertTouchToNodeSpace:touch];
    [self userTappedAtPoint:location];
}

@end
