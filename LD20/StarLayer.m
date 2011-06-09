//
//  StarLayer.m
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StarLayer.h"


@implementation StarLayer

// separate star layers 
CCSprite* starBgrL_2_0;
CCSprite* starBgrL_2_1;
CCSprite* starBgrL_1_0;
CCSprite* starBgrL_1_1;
CCSprite* starBgrL0_0;
CCSprite* starBgrL0_1;
CCSprite* starBgrL1_0;
CCSprite* starBgrL1_1;

// layers velocities
const float STAR_LAYER_2_SPEED = -60.0;
const float STAR_LAYER_1_SPEED = -70.0;
const float STAR_LAYER0_SPEED = -100.0;
const float STAR_LAYER1_SPEED = -130.0;


#pragma mark -

- (id)initOnLayer:(CCLayer*)layer
{
	if((self=[super init])) {
        [self setupStarsOnLayer:layer];
    }
    return self;
}

- (void)dealloc {
    [starBgrL_2_0 release];
    [starBgrL_2_1 release];
    [starBgrL_1_0 release];
    [starBgrL_1_1 release];
    [starBgrL0_0 release];
    [starBgrL0_1 release];
    [starBgrL1_0 release];
    [starBgrL1_1 release];
    
    [super dealloc];
}

- (CCSprite*)spriteWithFileName:(NSString*)fname onLayer:(CCLayer*)layer withPosition:(CGPoint)pos {
    CCSprite* sprite = [CCSprite spriteWithFile:fname];
    sprite.position = pos;
    [layer addChild:sprite];
    
    return sprite;
}

-(void)setupStarsOnLayer:(CCLayer*)layer {
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    CGPoint screenCenter = CGPointMake(size.width/2, size.height/2);

    starBgrL_2_0 = [[self spriteWithFileName:@"starBgr-2.png" onLayer:layer withPosition:CGPointMake(screenCenter.x, screenCenter.y)] retain];
    
    // above the screen
    starBgrL_2_1 = [[self spriteWithFileName:@"starBgr-2.png" onLayer:layer withPosition:CGPointMake(screenCenter.x, screenCenter.y + 480)] retain];
    
    starBgrL_1_0 = [[self spriteWithFileName:@"starBgr-1.png" onLayer:layer withPosition:CGPointMake(screenCenter.x, screenCenter.y)] retain];
    
    // above the screen
    starBgrL_1_1 = [[self spriteWithFileName:@"starBgr-1.png" onLayer:layer withPosition:CGPointMake(screenCenter.x, screenCenter.y + 480)] retain];

    starBgrL0_0 = [[self spriteWithFileName:@"starBgr.png" onLayer:layer withPosition:CGPointMake(screenCenter.x, screenCenter.y)] retain];
    
    // above the screen
    starBgrL0_1 = [[self spriteWithFileName:@"starBgr.png" onLayer:layer withPosition:CGPointMake(screenCenter.x, screenCenter.y + 480)] retain];
    
    starBgrL1_0 = [[self spriteWithFileName:@"starBgr2.png" onLayer:layer withPosition:CGPointMake(screenCenter.x, screenCenter.y)] retain];
    
    // above the screen
    starBgrL1_1 = [[self spriteWithFileName:@"starBgr2.png" onLayer:layer withPosition:CGPointMake(screenCenter.x, screenCenter.y + 480)] retain];
}

#pragma mark - stars animation

-(void)animateStarSprite:(CCSprite*)stars withDeltaTime:(ccTime)deltaTime andSpeed:(CGFloat)speed {
    float delta = speed * deltaTime;
        
    CGSize size = [[CCDirector sharedDirector] winSize];
    CGPoint screenCenter = CGPointMake(size.width/2, size.height/2);
    
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
