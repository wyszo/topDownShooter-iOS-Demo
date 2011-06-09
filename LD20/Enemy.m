//
//  Enemy.m
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"
#import "Util.h"


@implementation Enemy

NSString* UFOK_SPRITE_FNAME = @"ufok1Small.png";


- (CCSprite*)createUfokSpriteOnLayer:(CCLayer*)layer withPos:(CGPoint)pos andZOrder:(int)zOrder {
    return [[Util getInstance] createRetainSpriteWithFName:UFOK_SPRITE_FNAME onLayer:layer withPos:pos andZOrder:zOrder];
}

- (id)initOnLayer:(CCLayer*)layer withPos:(CGPoint)pos andZOrder:(int)zOrder
{
	if((self=[super init])) {
        ufok1 = [self createUfokSpriteOnLayer:layer withPos:pos andZOrder:zOrder];
        hp = 100;
    }
    return self;
}


- (void)injureWithHp:(int)deltaHp {
    hp -= deltaHp;
}

- (BOOL)isAlive {
    if (hp <= 0)
        return NO;
    else return YES;
}


@end
