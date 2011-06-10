//
//  Enemy.m
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"
#import "Util.h"
#import "Consts.h"

@interface Enemy() 
- (CCSprite*)createUfokSpriteOnLayer:(CCLayer*)layer withPos:(CGPoint)pos andZOrder:(int)zOrder;
- (void)setupMovement;
@end


@implementation Enemy
@synthesize ufok1;

NSString* UFOK_SPRITE_FNAME = @"ufok1Small.png";

/**
 * Losuje czas, po jakim powinien spawnować się kolejny przeciwnik
 */
+ (float)randSpawnNextEnemyInterval {
    float min = SPAWN_NEXT_ENEMY_MIN_TIME_INTERVAL;
    float max = SPAWN_NEXT_ENEMY_MAX_TIME_INTERVAL;
    float span = max - min;
    
    float timeInterval = min + (arc4random() % (int)(span*100)) * 0.01;
    // NSLog(@"spawn enemies time interval: %f", timeInterval);
    
    return timeInterval;
}

- (id)initOnLayer:(CCLayer*)layer withZOrder:(int)zOrder andParentCollection:(NSMutableArray*)collection
{
	if((self=[super init])) {
        
        // init vars
        hp = 100;
        parentCollection = collection;
        
        // losowanie pozycji startowej 
        float ufokTexWidth = ufok1.textureRect.size.width;
        float minX = ufokTexWidth;
        int spawnSpaceWidth = [[Consts getInstance] windowSize].width - 2*ufokTexWidth;
        
        float posY = SCREEN_HEIGHT + ENEMY_SPAWN_POS_Y_OFFSET;
        CGPoint pos = CGPointMake(minX + arc4random() % spawnSpaceWidth, posY);
        
        // dodanie ufoka 
        ufok1 = [self createUfokSpriteOnLayer:layer withPos:pos andZOrder:zOrder];
        
        [self setupMovement];
    }
    return self;
}

- (void)dealloc {
    [ufok1 release];
    [super dealloc];
}

- (void)injureWithHp:(int)deltaHp {
    hp -= deltaHp;
}

- (BOOL)isAlive {
    if (hp <= 0)
        return NO;
    else return YES;
}

- (void)setupStrightDownMovement {
    float movementLifetime = 1.0/ENEMY_SPEED; 
    float deltaY = [[Consts getInstance] windowSize].height + 2*ENEMY_SPAWN_POS_Y_OFFSET;
    
    // setup movement & bullet cleanup after move anim 
    id moveAction = [CCMoveTo actionWithDuration:movementLifetime position:CGPointMake(ufok1.position.x, ufok1.position.y - deltaY)];
    
    id removeAction = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [parentCollection removeObject:self];
        [node removeFromParentAndCleanup:YES];
    }];
    
    id actionsSequence = [CCSequence actions:moveAction, removeAction, nil];
    [ufok1 runAction:actionsSequence];
}

- (void)setupMovement {
    [self setupStrightDownMovement];
    
    // [self setupBezierDownMovement];
}

#pragma mark - sprite utils 

- (CCSprite*)createUfokSpriteOnLayer:(CCLayer*)layer withPos:(CGPoint)pos andZOrder:(int)zOrder {
    return [[Util getInstance] createRetainSpriteWithFName:UFOK_SPRITE_FNAME onLayer:layer withPos:pos andZOrder:zOrder];
}

@end
