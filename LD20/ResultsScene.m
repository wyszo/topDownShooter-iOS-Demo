//
//  DeathScene.m
//  LD20
//
//  Created by tomek on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResultsScene.h"


@implementation ResultsScene

+(CCScene*) scene {
    CCScene* scene = [CCScene node];
    
    ResultsScene* layer = [ResultsScene node];
    [scene addChild:layer];
    
    return scene;
}


- (id)init {
    if ((self = [super init])) {
        
        // self.isTouchEnabled = YES;
        
        // [self addChild:<#(CCNode *)#>];
        
        NSString* str = @"Game Over";
        CCLabelTTF* resultsLbl = [CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:16];
        resultsLbl.position = ccp(160,16);
        [self addChild: resultsLbl z:55];

    }
    return self;
}

/*
 #pragma mark - touch dispatch
 
 - (void)registerWithTouchDispatcher {
 [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
 }
 
 - (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
 return YES;
 }
 
 - (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
 CGPoint location = [self convertTouchToNodeSpace:touch];
 
 [sprite runAction:[CCMoveTo actionWithDuration:1 position:location]];
 }
 */


@end
