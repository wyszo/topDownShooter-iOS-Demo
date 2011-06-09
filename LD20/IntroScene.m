//
//  IntroScene.m
//  LD20
//
//  Created by tomek on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IntroScene.h"
#import "GameLayer.h"


@implementation IntroScene

CGPoint screenCenter;

CCSprite* intro0;
CCSprite* intro1;
CCSprite* intro2;
CCSprite* laserCannon;

int currentScreenNr = 0;
BOOL duringFadeOut = NO;

const float FADE_IN_ANIM_LEN = 0.8;
const float FADE_OUT_ANIM_LEN = 0.8;

const float MOVE_ANIM_LEN = 1.05;
int animOffset = 20; // intro animation offsets


+(CCScene*) scene {
    CCScene* scene = [CCScene node];
    
    IntroScene* layer = [IntroScene node];
    [scene addChild:layer];
    
    return scene; 
}

- (id)init {
    if ((self = [super init])) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        screenCenter = CGPointMake(size.width/2, size.height/2);

        intro0 = [[CCSprite spriteWithFile:@"titleScreen.png"] retain];
        intro1 = [[CCSprite spriteWithFile:@"Intro1.png"] retain];
        intro2 = [[CCSprite spriteWithFile:@"Intro2.png"] retain];
        laserCannon = [[CCSprite spriteWithFile:@"LaserCannonScreen.png"] retain];
        
        [self showIntroViewWithSprite:intro0];
        
        self.isTouchEnabled = YES;
    }
    return self;
}

- (void)dealloc {
    [intro0 release];
    [intro1 release];
    [intro2 release];
    [laserCannon release];
    [super dealloc];
}

#pragma mark - views

- (void)showIntroViewWithSprite:(CCSprite*)introView {
    introView.position = screenCenter;
    introView.opacity = 0.0;
    
    id fadeAnim = [CCFadeIn actionWithDuration:FADE_IN_ANIM_LEN];
    [introView runAction:fadeAnim];
    
    [self addChild:introView];
}

- (void)dismissViewWithFadeOut {
    id fadeAnim = [CCFadeOut actionWithDuration:FADE_OUT_ANIM_LEN];
    
    if (currentScreenNr == 0) {
        [intro0 stopAllActions];
        [intro0 runAction:fadeAnim];
    } else if (currentScreenNr == 1) {
        [intro1 stopAllActions];
        [intro1 runAction:fadeAnim];
        [intro1 runAction:[CCMoveBy actionWithDuration:MOVE_ANIM_LEN position:CGPointMake(animOffset, animOffset)]];
    } else if (currentScreenNr == 2) {
        [intro2 stopAllActions];
        [intro2 runAction:fadeAnim];
        [intro2 runAction:[CCMoveBy actionWithDuration:MOVE_ANIM_LEN position:CGPointMake(animOffset, -animOffset)]];
    } else if (currentScreenNr == 3) {
        [laserCannon stopAllActions];
        [laserCannon runAction:fadeAnim];
        [laserCannon runAction:[CCMoveBy actionWithDuration:MOVE_ANIM_LEN position:CGPointMake(-animOffset, -animOffset)]];
    }
}

- (void)showView1:(ccTime)dt { 
    [self unschedule:@selector(showView1:)];
    [self showIntroViewWithSprite:intro1];
    [intro1 runAction:[CCMoveBy actionWithDuration:MOVE_ANIM_LEN position:CGPointMake(animOffset, animOffset)]];
    currentScreenNr = 1;
}

- (void)showView2:(ccTime)dt { 
    [self unschedule:@selector(showView2:)];
    [self showIntroViewWithSprite:intro2];
    [intro2 runAction:[CCMoveBy actionWithDuration:MOVE_ANIM_LEN position:CGPointMake(animOffset, -animOffset)]];
    currentScreenNr = 2;
}

- (void)showView3:(ccTime)dt {
    [self unschedule:@selector(showView3:)];   
    laserCannon.position = CGPointMake(laserCannon.position.x - animOffset, laserCannon.position.y - animOffset);
    [self showIntroViewWithSprite:laserCannon];
    [laserCannon runAction:[CCMoveBy actionWithDuration:MOVE_ANIM_LEN position:CGPointMake(-animOffset, -animOffset)]];
    currentScreenNr = 3;
}

- (void)jumpToNextView:(ccTime)dt {
    [self unschedule:@selector(jumpToNextView:)];    
    CCScene* mainScene = [GameLayer scene];
    [[CCDirector sharedDirector] replaceScene:mainScene];    
}

#pragma mark - touch dispatch

- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (currentScreenNr == 0) {
        [self dismissViewWithFadeOut];
        [self schedule:@selector(showView1:) interval:FADE_OUT_ANIM_LEN];
        //CCTimer* timer = [[CCTimer alloc] initWithTarget:self selector:@selector(showView1:) interval:FADE_OUT_ANIM_LEN];
    } else if (currentScreenNr == 1) {
        [self dismissViewWithFadeOut];
        [self schedule:@selector(showView2:) interval:FADE_OUT_ANIM_LEN];
        //CCTimer* timer = [[CCTimer alloc] initWithTarget:self selector:@selector(showView2:) interval:FADE_OUT_ANIM_LEN];
    } else if (currentScreenNr == 2) {
        [self dismissViewWithFadeOut];
        [self schedule:@selector(showView3:) interval:FADE_OUT_ANIM_LEN];
        //[[CCTimer alloc] initWithTarget:self selector:@selector(showView3:) interval:FADE_OUT_ANIM_LEN];
    } else if (currentScreenNr == 3) {
        [self dismissViewWithFadeOut];
        [self schedule:@selector(jumpToNextView:) interval:FADE_OUT_ANIM_LEN];
        //[[CCTimer alloc] initWithTarget:self selector:@selector(jumpToNextView:) interval:FADE_OUT_ANIM_LEN];
    }
}

@end
