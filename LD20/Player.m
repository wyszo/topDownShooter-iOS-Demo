//
//  Player.m
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player

- (void)resetState {
    sprite.position = CGPointMake(100, 100);
}

- (id)initOnLayer:(CCLayer*)layer
{
	if((self=[super init])) {
        
        // add player main sprite 
        sprite = [[CCSprite spriteWithFile:@"player.png"] retain];
        [layer addChild:sprite];
        sprite.scale = 0.5f;
        
        [self resetState];
    }
    return self;
}

@end
