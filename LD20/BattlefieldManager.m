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

#pragma mark - bullets management

- (void)checkBulletsCollisions {
    
}

- (void)spawnEnemyBulletFromPos:(CGPoint)point {
    
}

- (void)spawnPlayerBullet {
    [player reloadCannon];
    
    CCSprite* newBullet = [[CCSprite spriteWithFile:BULLET_SPRITE_FNAME] retain];
    
    newBullet.position = player.sprite.position;
    float lifetime = 2;
    float deltaY = [[Consts getInstance] windowSize].height;
    
    // setup movement & bullet cleanup after move anim 
    id moveAction = [CCMoveTo actionWithDuration:lifetime position:CGPointMake(newBullet.position.x, newBullet.position.y + deltaY)];
    
    id removeAction = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [playerBullets removeObject:node];
        [node removeFromParentAndCleanup:YES];
    }];
    
    id actionsSequence = [CCSequence actions:moveAction, removeAction, nil];
    [newBullet runAction:actionsSequence];
    
    // add to canvas & bullets list
    [canvasLayer addChild:newBullet z:PLAYER_BULLET_Z];    
    [playerBullets addObject:newBullet];
}

-(void)nextFrame:(ccTime)deltaTime {
    
    [self checkBulletsCollisions];
}

/**
 * Procedura obsługi tapnięć 
 */ 
- (void)userTappedAtPoint:(CGPoint)point {
    
    if (player.cannonReloaded)
        [self spawnPlayerBullet];
}

@end
