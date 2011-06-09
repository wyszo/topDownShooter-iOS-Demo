//
//  Player.m
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player
@synthesize sprite;

- (void)resetState {
    sprite.position = CGPointMake(100, 60);
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

- (void)dealloc {
    [sprite release];
    [super dealloc];
}

@end