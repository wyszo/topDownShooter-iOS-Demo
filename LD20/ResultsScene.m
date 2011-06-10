//
//  DeathScene.m
//  LD20
//
//  Created by tomek on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResultsScene.h"
#import "Consts.h"


@implementation ResultsScene

static int score;

+(CCScene*) scene {
    CCScene* scene = [CCScene node];
    
    ResultsScene* layer = [ResultsScene node];
    [scene addChild:layer];
    
    return scene;
}

+(void) setScore:(double)aScore {
    score = aScore;
}

+(void)pushResultsScreen {
    CCScene* resultsScene = [ResultsScene scene];
    [[CCDirector sharedDirector] pushScene:resultsScene];  
}

- (void)addLabelWithText:(NSString*)text size:(int)size onPosition:(CGPoint)pos {
    NSString* fontName = @"Marker Felt";
    
    CCLabelTTF* lbl = [CCLabelTTF labelWithString:text fontName:fontName fontSize:size];
    lbl.position = pos;
    [self addChild: lbl];
}

- (void)addScreenLabels {
    // Game Over
    double y = SCREEN_HEIGHT - 60;
    [self addLabelWithText:@"GameOver" size:GAME_OVER_LBL_SIZE onPosition:CGPointMake(SCREEN_WIDTH/2, y)];
    
    // Your score
    y = SCREEN_HEIGHT - 120;
    [self addLabelWithText:[NSString stringWithFormat:@"Your score: %d",score] size:YOUR_SCORE_LBL_SIZE onPosition:CGPointMake(SCREEN_WIDTH/2, y)];
}

- (id)init {
    if ((self = [super init])) {
        self.isTouchEnabled = YES;
     
        [self addScreenLabels];
    }
    return self;
}

BOOL touchStarted;

#pragma mark - touch dispatch

- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    touchStarted = YES;
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    // CGPoint location = [self convertTouchToNodeSpace:touch];

    if (touchStarted)
        [[CCDirector sharedDirector] popScene];
}

@end
