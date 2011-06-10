//
//  Enemy.h
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"


@interface Enemy : NSObject {
    CCSprite* ufok1;
    int hp;
    NSMutableArray* parentCollection;
}

- (id)initOnLayer:(CCLayer*)layer withZOrder:(int)zOrder andParentCollection:(NSMutableArray*)collection;
- (void)injureWithHp:(int)hp;
- (BOOL)isAlive;
+ (float)randSpawnNextEnemyInterval;

@end
