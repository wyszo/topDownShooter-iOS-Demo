//
//  Player.m
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "Consts.h"


@implementation Player
@synthesize sprite;

- (void)resetState {
    sprite.position = CGPointMake(100, 60);
}

- (id)initOnLayer:(CCLayer*)layer
{
	if((self=[super init])) {
        
        // add player main sprite 
        sprite = [[CCSprite spriteWithFile:@"playerSmall.png"] retain];
        [layer addChild:sprite z:PLAYER_SHIP_Z];
        
        [self resetState];
    }
    return self;
}

- (void)dealloc {
    [sprite release];
    [super dealloc];
}

- (void)moveWithSpeed:(double)speed {
    
    // ogranicz prędkość
    /*
     int max = 10;
     if(speed > max)
     speed = max;
     else if(speed < -max)
     speed = -max;
     */
    
    // Nie pozwól graczowi wylecieć poza obszar gry   
    if((speed > 0 || sprite.position.x > sprite.textureRect.size.width) && (speed < 0 || sprite.position.x < [[Consts getInstance] windowSize].width - sprite.textureRect.size.width))
    [sprite setPosition:ccp(sprite.position.x + speed,sprite.position.y)];
}

@end
