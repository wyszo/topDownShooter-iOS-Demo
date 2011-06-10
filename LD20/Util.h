//
//  Util.h
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

#define SCORE [Util getInstance].score


@interface Util : NSObject {
    int _score;
}

@property (nonatomic) int score;

- (CCSprite*)createRetainSpriteWithFName:(NSString*)fname onLayer:(CCLayer*)layer withPos:(CGPoint)pos andZOrder:(int)zOrder;
+ (BOOL)pointWithX:(double)x y:(double)y colidedWithObjectWithX:(double)objX y:(double)objY width:(double)objWidth andHeight:(double)objHeight;

+ (Util*)getInstance;

@end
