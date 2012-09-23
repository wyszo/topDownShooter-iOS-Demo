//
//  SceneSnippet.m
//  LD20
//
//  Created by tomek on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SceneSnippet.h"


@implementation SceneSnippet

+(CCScene*) scene {
    CCScene* scene = [CCScene node];
    
    SceneSnippet* layer = [SceneSnippet node];
    [scene addChild:layer];
    
    return scene; 
}

- (id)init {
    if ((self = [super init])) {
        
        // self.isTouchEnabled = YES;
        
        // [self addChild:<#(CCNode *)#>];
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