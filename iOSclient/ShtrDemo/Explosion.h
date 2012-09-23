//
//  Explosion.h
//  LD20
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface Explosion : NSObject {
    CCSprite* expl;
}

- (id)initOnLayer:(CCLayer*)layer withZOrder:(int)ZOrder andPos:(CGPoint)pos;

@end
