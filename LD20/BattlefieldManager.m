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
#import "Util.h"
#import "Enemy.h"

@interface BattlefieldManager() 
- (void)spawnEnemy;
- (void)scheduleNextSpawnEnemyAction;
- (CCSprite*)createBulletSpriteOnWithPos:(CGPoint)pos andZOrder:(int)zOrder;
@end


@implementation BattlefieldManager
@synthesize player;

NSString* BULLET_SPRITE_FNAME = @"bulletSmall.png";


- (void)resetState {
    [player resetState];
}

#pragma mark - class lifecycle

- (id)initOnLayer:(CCLayer*)layer
{
	if((self=[super init])) {
        canvasLayer = layer;
        player = [[Player alloc] initOnLayer:layer];
        [self resetState];
        
        // enemy 
        // ufok1 = [[self createUfokSprite] retain];
        // ufok1.position = CGPointMake(200, 300);
        //[layer addChild:ufok1 z:ENEMY_SHIP_Z];
        
        // player bullets, enemy bullets
        playerBullets = [[NSMutableArray array] retain];
        enemyBullets = [[NSMutableArray array] retain];
        
        // napływanie nowych wrogów     
        [self scheduleNextSpawnEnemyAction];
        

    }
    return self;
}

- (void)dealloc {
    [playerBullets release];
    [enemyBullets release];
    
    [player release];
    [bullet release];
    //[ufok1 release];
    [super dealloc];
}

#pragma mark - spawning enemies

- (void)spawnEnemy {
    // enemies!!!
    [enemyBullets addObject:[[Enemy alloc] initOnLayer:canvasLayer withZOrder:ENEMY_SHIP_Z andParentCollection:enemyBullets]];
    
    [self scheduleNextSpawnEnemyAction];
}

- (void)scheduleNextSpawnEnemyAction {
    id action = [CCCallFunc actionWithTarget:self selector:@selector(spawnEnemy)];
    float deltaTime = [Enemy randSpawnNextEnemyInterval];
    id delay = [CCDelayTime actionWithDuration:deltaTime];
    [CANVAS runAction:[CCSequence actions:delay, action, nil]];
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
    float lifetime = 1.0f/BULLET_SPEED;
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

#pragma mark - sprite utilities

- (CCSprite*)createBulletSpriteOnWithPos:(CGPoint)pos andZOrder:(int)zOrder {
    return [[Util getInstance] createRetainSpriteWithFName:BULLET_SPRITE_FNAME onLayer:canvasLayer withPos:pos andZOrder:zOrder];
}

@end
