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

NSString* BULLET_SPRITE_FNAME = @"bulletSmall.png";
NSString* UFOK_SPRITE_FNAME = @"ufok1Small.png";

- (void)resetState {
    [player resetState];
}

#pragma mark - sprite utilities

- (CCSprite*)createRetainSpriteWithFName:(NSString*)fname onLayer:(CCLayer*)layer withPos:(CGPoint)pos andZOrder:(int)zOrder {
    
    CCSprite* newSprite = [CCSprite spriteWithFile:fname];
    [newSprite retain];
    [layer addChild:newSprite z:zOrder];
    newSprite.position = pos;
    
    return newSprite;
}

- (CCSprite*)createBulletSpriteOnWithPos:(CGPoint)pos andZOrder:(int)zOrder {
    return [self createRetainSpriteWithFName:BULLET_SPRITE_FNAME onLayer:canvasLayer withPos:pos andZOrder:zOrder];
}

- (CCSprite*)createUfokSpriteOnWithPos:(CGPoint)pos andZOrder:(int)zOrder {
    return [self createRetainSpriteWithFName:UFOK_SPRITE_FNAME onLayer:canvasLayer withPos:pos andZOrder:zOrder];
}

- (CCSprite*)createUfokSprite {
    CCSprite* newSprite = [CCSprite spriteWithFile:UFOK_SPRITE_FNAME];
    
    [newSprite retain];
    return newSprite;
}

#pragma mark - class lifecycle

- (id)initOnLayer:(CCLayer*)layer
{
	if((self=[super init])) {
        canvasLayer = layer;
        player = [[Player alloc] initOnLayer:layer];
        [self resetState];
                
        // bullet
        bullet = [self createBulletSpriteOnWithPos:CGPointMake(200, 300) andZOrder:PLAYER_BULLET_Z];
        
        // bullet = [[self createBulletSpriteWithPos:CGPointMake(200, 100)] retain];
        
        // enemy 
        ufok1 = [[self createUfokSprite] retain];
        ufok1.position = CGPointMake(200, 300);
        [layer addChild:ufok1 z:ENEMY_SHIP_Z];
        
        // player bullets, enemy bullets
        playerBullets = [[NSMutableArray array] retain];
        enemyBullets = [[NSMutableArray array] retain];
    }
    return self;
}

- (void)dealloc {
    [playerBullets release];
    [enemyBullets release];
    
    [player release];
    [bullet release];
    [ufok1 release];
    [super dealloc];
}

- (void)checkBulletsCollisions {
    
}

- (void)movePlayerBullets {
    
}

- (void)moveEnemyBullets {
    // bullets
    //    bullet.position = CGPointMake(bullet.position.x, bullet.position.y + BULLET_SPEED * deltaTime);
}

- (void)spawnPlayerBullet {
    CCSprite* newBullet = [[CCSprite spriteWithFile:BULLET_SPRITE_FNAME] retain];
    
    newBullet.position = player.sprite.position;
    
    float time = 2;
    float deltaY = [[Consts getInstance] windowSize].height;
    
    // setup movement
    [newBullet runAction:[CCMoveTo actionWithDuration:time position:CGPointMake(newBullet.position.x, newBullet.position.y + deltaY)]];
    
    // add to canvas & bullets list
    [canvasLayer addChild:newBullet z:PLAYER_BULLET_Z];    
    [playerBullets addObject:newBullet];
}

-(void)nextFrame:(ccTime)deltaTime {
    
    [self checkBulletsCollisions];
    [self movePlayerBullets];
    [self moveEnemyBullets];
}

/**
 * Procedura obsługi tapnięć 
 */ 
- (void)userTappedAtPoint:(CGPoint)point {
    
    [self spawnPlayerBullet];
    
//    [bullet stopAllActions];
//    [bullet runAction:[CCMoveTo actionWithDuration:1 position:point]];
}

@end
