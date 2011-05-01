//
//  IntroScene.m
//  LD20
//
//  Created by tomek on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IntroScene.h"
#import "HelloWorldLayer.h"


@implementation IntroScene

CGPoint screenCenter;

CCSprite* intro1;
CCSprite* intro2;
CCSprite* laserCannon;

int currentScreenNr = 0;
BOOL duringFadeOut = NO;

const float FADE_IN_ANIM_LEN = 1.4;
const float FADE_OUT_ANIM_LEN = 1.4;

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

        intro1 = [[CCSprite spriteWithFile:@"Intro1.png"] retain];
        intro2 = [[CCSprite spriteWithFile:@"Intro2.png"] retain];
        laserCannon = [[CCSprite spriteWithFile:@"LaserCannonScreen.png"] retain];
        
        [self showIntroViewWithSprite:intro1];
        currentScreenNr = 1;
        
        self.isTouchEnabled = YES;
    }
    return self;
}

- (void)dealloc {
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
    
    if (currentScreenNr == 1) {
        [intro1 stopAllActions];
        [intro1 runAction:fadeAnim];
//        [intro1 runAction:[CCMoveBy actionWithDuration:2 position:CGPointMake(10, 10)]];
    } else if (currentScreenNr == 2) {
        [intro2 stopAllActions];
        [intro2 runAction:fadeAnim];
    } else if (currentScreenNr == 3) {
        [laserCannon stopAllActions];
        [laserCannon runAction:fadeAnim];
    }
}

- (void)showView2:(ccTime)dt {
//- (void)showView2 {    
    [self unschedule:@selector(showView2:)];
    [self showIntroViewWithSprite:intro2];
    currentScreenNr = 2;
}

- (void)showView3:(ccTime)dt {
    [self unschedule:@selector(showView3:)];    
    [self showIntroViewWithSprite:laserCannon];
    currentScreenNr = 3;
}

- (void)jumpToNextView:(ccTime)dt {
    [self unschedule:@selector(jumpToNextView:)];    
    CCScene* mainScene = [HelloWorldLayer scene];
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
    if (currentScreenNr == 1) {
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
