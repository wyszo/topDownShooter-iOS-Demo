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
- (void)destroySelf;
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
    
    if (hp <= 0) {
        // usuń wierzchołek, usuń z listy wrogów
        [self destroySelf];
        SCORE += SCORE_INCREMENT_VAL;
    }
} 

- (BOOL)isAlive {
    if (hp <= 0)
        return NO; 
    else return YES;
}

- (void)destroySelf {
    [parentCollection removeObject:self];
    [ufok1 removeFromParentAndCleanup:YES]; 
}

- (void)setupStrightDownMovement {
    float movementLifetime = 1.0/ENEMY_SPEED; 
    float deltaY = [[Consts getInstance] windowSize].height + 2*ENEMY_SPAWN_POS_Y_OFFSET; 
     
    // setup movement & bullet cleanup after move anim 
    id moveAction = [CCMoveTo actionWithDuration:movementLifetime position:CGPointMake(ufok1.position.x, ufok1.position.y - deltaY)];
    
    id removeAction = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [self destroySelf];
    }];
    
    id actionsSequence = [CCSequence actions:moveAction, removeAction, nil];
    [ufok1 runAction:actionsSequence];
}

- (ccBezierConfig)createUfokBezierFrom:(CGPoint)startPos withHorizontalSpan:(int)span {
    float deltaY = [[Consts getInstance] windowSize].height + 2*ENEMY_SPAWN_POS_Y_OFFSET; 
    float controlPoint1_Y = 300;
    float controlPoint2_Y = 100;
    int controlPoint1_X_delta, controlPoint2_X_delta;
    int controlPoint1_Y_delta, controlPoint2_Y_delta;
    int vertCPSpan = ENEMY_BEZIER_CONTROL_POINT_VERTICAL_SPAN;
    
    ccBezierConfig bezier;
    bezier.endPosition = CGPointMake(startPos.x, startPos.y - deltaY);
    
    controlPoint1_X_delta = -span + (arc4random() % (2*span));
    controlPoint2_X_delta = -span + (arc4random() % (2*span));
    
    controlPoint1_Y_delta = - vertCPSpan + (arc4random() % (2*vertCPSpan));
    controlPoint2_Y_delta = - vertCPSpan + (arc4random() % (2*vertCPSpan));
    
    bezier.controlPoint_1 = CGPointMake(startPos.x + controlPoint1_X_delta, controlPoint1_Y + controlPoint1_Y_delta);
    bezier.controlPoint_2 = CGPointMake(startPos.x + controlPoint2_X_delta, controlPoint2_Y + controlPoint2_Y_delta);
    
    return bezier;
}

- (void)setupBezierDownMovement {
    float movementLifetime = 1.0/ENEMY_SPEED; 
    CGPoint startPos = CGPointMake(ufok1.position.x, ufok1.position.y);
    
    ufok1.position = startPos;
    
    ccBezierConfig bezier = [self createUfokBezierFrom:startPos withHorizontalSpan:ENEMY_BEZIER_HORIZONTAL_SPAN];
    
    id bezierMoveAction = [CCBezierTo actionWithDuration:movementLifetime bezier:bezier];
    
    id removeAction = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [self destroySelf];
    }];
    
    id actionsSequence = [CCSequence actions:bezierMoveAction, removeAction, nil];
    [ufok1 runAction:actionsSequence];
}

- (void)setupMovement {
    // [self setupStrightDownMovement];
    
    [self setupBezierDownMovement];
}

#pragma mark - sprite utils 

- (CCSprite*)createUfokSpriteOnLayer:(CCLayer*)layer withPos:(CGPoint)pos andZOrder:(int)zOrder {
    return [[Util getInstance] createRetainSpriteWithFName:UFOK_SPRITE_FNAME onLayer:layer withPos:pos andZOrder:zOrder];
}

@end
