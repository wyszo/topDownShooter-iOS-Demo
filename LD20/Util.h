//
//  Util.h
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

#define SCORE [Util getInstance].score
#define PLAYER_NAME [Util getInstance].playerName


@interface Util : NSObject {
    int _score;
}

@property (nonatomic) int score;
@property (nonatomic, retain) NSString* playerName;

- (CCSprite*)createRetainSpriteWithFName:(NSString*)fname onLayer:(CCLayer*)layer withPos:(CGPoint)pos andZOrder:(int)zOrder;
+ (CGRect)scaleRect:(CGRect)rect by:(double)coef;
+ (BOOL)pointWithX:(double)x y:(double)y colidedWithObjectWithX:(double)objX y:(double)objY width:(double)objWidth andHeight:(double)objHeight;
+ (BOOL)sprite:(CCSprite*)spr1 collidesWithSprite:(CCSprite*)spr2 withTolerance:(float)tolerance;

+ (Util*)getInstance;

@end
