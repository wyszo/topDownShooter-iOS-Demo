//
//  BulletManager.m
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BattlefieldManager.h"
#import "Player.h"
#import "Consts.h"


@implementation BattlefieldManager
@synthesize player;

- (void)resetState {
    [player resetState];
}

- (id)initOnLayer:(CCLayer*)layer
{
	if((self=[super init])) {
        player = [[Player alloc] initOnLayer:layer];
        [self resetState];
        
        
        // bullet
        bullet = [[CCSprite spriteWithFile:@"bullet.png"] retain];
        bullet.position = CGPointMake(200, 100);
        bullet.scale = 0.5;
        [layer addChild:bullet];
        
        // enemy 
        ufok1 = [[CCSprite spriteWithFile:@"ufok1.png"] retain];
        ufok1.position = CGPointMake(200, 300);
        ufok1.scale = 0.5;
        [layer addChild:ufok1];
    }
    return self;
}

- (void)dealloc {
    [player release];
    [bullet release];
    [ufok1 release];
    [super dealloc];
}

-(void)nextFrame:(ccTime)deltaTime {
    // bullets
    bullet.position = CGPointMake(bullet.position.x, bullet.position.y + BULLET_SPEED * deltaTime);
}

/**
 * Procedura obsługi tapnięć 
 */ 
- (void)userTappedAtPoint:(CGPoint)point {
    
    [bullet stopAllActions];
    [bullet runAction:[CCMoveTo actionWithDuration:1 position:point]];
}

@end
