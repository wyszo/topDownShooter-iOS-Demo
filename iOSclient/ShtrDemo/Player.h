//
//  Player.h
//  LD20
//
//  Created by tomek on 6/9/11.
//

#import "cocos2d.h"


@interface Player : NSObject {
    CCSprite* sprite;
    BOOL _cannonReloaded;
}

@property(nonatomic, retain) CCSprite* sprite;
@property(nonatomic, readonly) BOOL cannonReloaded;

- (id)initOnLayer:(CCLayer *)layer;
- (void)resetState;
- (void)moveWithSpeed:(double)speed;
- (void)reloadCannon;

@end
