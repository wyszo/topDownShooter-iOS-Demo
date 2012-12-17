//
//  Enemy.h
//  LD20
//
//  Created by tomek on 6/9/11.
//

#import "cocos2d.h"


@interface Enemy : NSObject {
    CCSprite* sprite;
    int hp;
    NSMutableArray* parentCollection;
}

@property(nonatomic, retain) CCSprite* sprite;

- (id)initOnLayer:(CCLayer*)layer withZOrder:(int)zOrder andParentCollection:(NSMutableArray*)collection;
- (void)injureWithHp:(int)hp;
- (BOOL)isAlive;
+ (float)randSpawnNextEnemyInterval;

@end
