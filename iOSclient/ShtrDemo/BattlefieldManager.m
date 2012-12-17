//
//  BulletManager.m
//  LD20
//
//  Created by tomek on 6/9/11.
//

#import "BattlefieldManager.h"
#import "Player.h"
#import "Consts.h"
#import "Util.h"
#import "Enemy.h"
#import "ResultsScene.h"
#import "SimpleAudioEngine.h"
#import "Settings.h"

static NSString* BULLET_SPRITE_FNAME = @"bulletSmall.png";


@interface BattlefieldManager() 
- (void)spawnEnemy;
- (void)scheduleNextSpawnEnemyAction;
- (CCSprite*)createBulletSpriteOnWithPos:(CGPoint)pos andZOrder:(int)zOrder;
- (void)startGame;
@end


@implementation BattlefieldManager
@synthesize player;

- (void)resetObjectLists {
    // reset player bullets
    for (CCSprite* bullet in playerBullets) {
        [bullet removeFromParentAndCleanup:NO];
    }
    [playerBullets removeAllObjects];
    
    // reset enemies
    for (Enemy* enemy in enemies) {
        [enemy.sprite removeFromParentAndCleanup:YES];
    }
    [enemies removeAllObjects];
    
    // reset enemy bullets
    for (CCSprite* enemyBullet in enemyBullets) {
        ;
    }
    [enemyBullets removeAllObjects];
    
    [self startGame];
}

- (void)resetState {
    [player resetState];
    [self resetObjectLists];
}

- (void)startGame {
    [self scheduleNextSpawnEnemyAction];
}

#pragma mark - class lifecycle

- (id)initOnLayer:(CCLayer*)layer {
	if (self = [super init]) {
        canvasLayer = layer;
        player = [[Player alloc] initOnLayer:layer];
        [self resetState];
        
        // player bullets, enemy bullets
        playerBullets = [[NSMutableArray array] retain];
        enemyBullets = [[NSMutableArray array] retain];
        enemies = [[NSMutableArray array] retain];
    }   
    return self;
}

- (void)dealloc {
    [playerBullets release];
    [enemyBullets release];
    [enemies release];
    
    [player release];
    [super dealloc];
}


#pragma mark - spawning enemies

- (void)spawnEnemy {
    [enemies addObject:[[Enemy alloc] initOnLayer:canvasLayer withZOrder:ENEMY_SHIP_Z andParentCollection:enemies]];
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
    // check each one with each other
    int bulletX, bulletY, bulletWidth, bulletHeight;
    int bulletCenterX, bulletCenterY;
    int enemyX, enemyY, enemyWidth, enemyHeight;
    
    NSMutableArray* bulletsToRemove = [NSMutableArray array];
    NSMutableArray* enemiesToBeHit = [NSMutableArray array];
    BOOL nextIteration = NO;
    
    for (CCSprite* bullet in playerBullets) {
        nextIteration = NO;
        
        for (Enemy* enemy in enemies) {
            // bullet info
            bulletX = bullet.position.x;
            bulletY = bullet.position.y;
            bulletWidth = bullet.textureRect.size.width;
            bulletHeight = bullet.textureRect.size.height;
            bulletCenterX = bulletX + bulletWidth/2;
            bulletCenterY = bulletY + bulletHeight/2;            
            
            // enemy info 
            enemyWidth = enemy.sprite.textureRect.size.width;
            enemyHeight = enemy.sprite.textureRect.size.height;
            enemyX = enemy.sprite.position.x - enemyWidth/2;
            enemyY = enemy.sprite.position.y;
            
            // collision check
            if ([Util pointWithX:bulletX y:bulletY colidedWithObjectWithX:enemyX y:enemyY width:enemyWidth andHeight:enemyHeight]) {

                // hit
                [bulletsToRemove addObject:bullet];
                [enemiesToBeHit addObject:enemy];
                nextIteration = YES;
                break;
            }         
        }
        if (nextIteration) 
            continue;
    }
    
    // remove bullets which hit the target
    for (CCSprite* bullet in bulletsToRemove) 
        [bullet removeFromParentAndCleanup:YES];
    [playerBullets removeObjectsInArray:bulletsToRemove];
    
    // remove killed enemies
    for (Enemy* enemy in enemiesToBeHit) {
        [enemy injureWithHp:BULLET_HIT_TAKES_HP];
    }
}

- (void)spawnEnemyBulletFromPos:(CGPoint)point {
    // this should be Enemy class method!
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
    
    if (kSetting_SoundEnabled) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"gunshot.wav"];
    }
}

#pragma mark - collisions

- (void)checkPlayerEnemiesCollisions {    
    for (Enemy* enemy in enemies) 
        if ([Util sprite:enemy.sprite collidesWithSprite:player.sprite withTolerance:0.35]) {
            
            NSLog(@"DEAD!!!");
            double score = SCORE;
            
            if (!kCheat_PlayerInvincible) {
                [CANVAS stopAllActions];
                [self resetState];
                [ResultsScene setScore:score];
                [ResultsScene pushResultsScreen];
                
                if (kSetting_SoundEnabled) {
                    [[SimpleAudioEngine sharedEngine] playEffect:@"explosion.wav"];
                }
            }
        }
}

#pragma mark - simulation step

- (void)nextFrame:(ccTime)deltaTime {
    
    [self checkBulletsCollisions];
    [self checkPlayerEnemiesCollisions];
}

/**
 * Tap callback
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
