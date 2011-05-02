//
//  HelloWorldLayer.m
//  LD20
//
//  Created by tomek on 5/1/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "CCTouchDispatcher.h"

@implementation HelloWorldLayer

CCSprite* player;
CCSprite* bullet;
CCSprite* ufok1;
CCSprite* starBgrL_2_0;
CCSprite* starBgrL_2_1;
CCSprite* starBgrL_1_0;
CCSprite* starBgrL_1_1;
CCSprite* starBgrL0_0;
CCSprite* starBgrL0_1;
CCSprite* starBgrL1_0;
CCSprite* starBgrL1_1;

CGPoint screenCenter;

const float BULLET_SPEED = 90.0;
const float STAR_LAYER_2_SPEED = -60.0;
const float STAR_LAYER_1_SPEED = -70.0;
const float STAR_LAYER0_SPEED = -100.0;
const float STAR_LAYER1_SPEED = -130.0;


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)setupStars {
    {
        // starBgr
        starBgrL_2_0 = [[CCSprite spriteWithFile:@"starBgr-2.png"] retain];
        starBgrL_2_0.position = CGPointMake(screenCenter.x, screenCenter.y);
        [self addChild:starBgrL_2_0];
        
        // stars - above the screen
        starBgrL_2_1 = [[CCSprite spriteWithFile:@"starBgr-2.png"] retain];
        starBgrL_2_1.position = CGPointMake(screenCenter.x, screenCenter.y + 480);
        [self addChild:starBgrL_2_1];
    }
    
    
    {
        // starBgr
        starBgrL_1_0 = [[CCSprite spriteWithFile:@"starBgr-1.png"] retain];
        starBgrL_1_0.position = CGPointMake(screenCenter.x, screenCenter.y);
        [self addChild:starBgrL_1_0];
        
        // stars - above the screen
        starBgrL_1_1 = [[CCSprite spriteWithFile:@"starBgr-1.png"] retain];
        starBgrL_1_1.position = CGPointMake(screenCenter.x, screenCenter.y + 480);
        [self addChild:starBgrL_1_1];
    }
    
    {
        // starBgr
        starBgrL0_0 = [[CCSprite spriteWithFile:@"starBgr.png"] retain];
        starBgrL0_0.position = CGPointMake(screenCenter.x, screenCenter.y);
        [self addChild:starBgrL0_0];
        
        // stars - above the screen
        starBgrL0_1 = [[CCSprite spriteWithFile:@"starBgr.png"] retain];
        starBgrL0_1.position = CGPointMake(screenCenter.x, screenCenter.y + 480);
        [self addChild:starBgrL0_1];
    }
    
    {
        // starBgr
        starBgrL1_0 = [[CCSprite spriteWithFile:@"starBgr2.png"] retain];
        starBgrL1_0.position = CGPointMake(screenCenter.x, screenCenter.y);
        [self addChild:starBgrL1_0];
        
        // stars - above the screen
        starBgrL1_1 = [[CCSprite spriteWithFile:@"starBgr2.png"] retain];
        starBgrL1_1.position = CGPointMake(screenCenter.x, screenCenter.y + 480);
        [self addChild:starBgrL1_1]; 
    }

}

-(void)loadLevel {
    CGSize size = [[CCDirector sharedDirector] winSize];
    screenCenter = CGPointMake(size.width/2, size.height/2);
    
    [self setupStars];
    
    // player
    player = [[CCSprite spriteWithFile:@"player.png"] retain];
    player.position = CGPointMake(100, 100);
    player.scale = 0.5f;
    [self addChild:player];
    
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

-(void)nextFrame:(ccTime)deltaTime {
    // bullets
    bullet.position = CGPointMake(bullet.position.x, bullet.position.y + BULLET_SPEED * deltaTime);
    
    // stars 
    [self animateStarsWithDeltaTime:deltaTime];
}

-(id) init
{
	if( (self=[super init])) {
		
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		// create and initialize a Label
//		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
        	
		// position the label on the center of the screen
//		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
//		[self addChild: label];
        
        [self loadLevel];
        
        self.isTouchEnabled = YES;
        
        // accelerometer
        //self.isAccelerometerEnabled = YES;
        //[[UIAccelerometer sharedAccelerometer] setUpdateInterval:1/60];
        
        // schedule update
        [self schedule:@selector(nextFrame:)];        
	}
	return self;
}

- (void) dealloc
{
    [starBgrL0_0 release];
    [starBgrL0_1 release];
    [player release];
    [bullet release];
    [ufok1 release];
	[super dealloc];
}

#pragma mark - accelerometer

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    
}

#pragma mark - touch dispatch

- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    [bullet stopAllActions];
    [bullet runAction:[CCMoveTo actionWithDuration:1 position:location]];
}

#pragma mark - stars animation

-(void)animateStarSprite:(CCSprite*)stars withDeltaTime:(ccTime)deltaTime andSpeed:(CGFloat)speed {
    float delta = speed * deltaTime;
    
    stars.position = CGPointMake(stars.position.x, stars.position.y + delta); 
    
    if (stars.position.y <= screenCenter.y -480)
        stars.position = CGPointMake(stars.position.x, 240 + 480);
}

-(void)animateStarLayer:(NSInteger)layerNr withDeltaTime:(ccTime)dt {
    [self animateStarSprite:starBgrL_2_0 withDeltaTime:dt andSpeed:STAR_LAYER_2_SPEED];
    [self animateStarSprite:starBgrL_2_1 withDeltaTime:dt andSpeed:STAR_LAYER_2_SPEED];
    
    [self animateStarSprite:starBgrL_1_0 withDeltaTime:dt andSpeed:STAR_LAYER_1_SPEED];
    [self animateStarSprite:starBgrL_1_1 withDeltaTime:dt andSpeed:STAR_LAYER_1_SPEED];
    
    [self animateStarSprite:starBgrL0_0 withDeltaTime:dt andSpeed:STAR_LAYER0_SPEED];
    [self animateStarSprite:starBgrL0_1 withDeltaTime:dt andSpeed:STAR_LAYER0_SPEED];
    
    [self animateStarSprite:starBgrL1_0 withDeltaTime:dt andSpeed:STAR_LAYER1_SPEED];
    [self animateStarSprite:starBgrL1_1 withDeltaTime:dt andSpeed:STAR_LAYER1_SPEED];
}

-(void)animateStarsWithDeltaTime:(ccTime)dt {
    [self animateStarLayer:0 withDeltaTime:dt];
}

@end
