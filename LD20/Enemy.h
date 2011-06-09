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
}

- (void)injureWithHp:(int)hp;
- (BOOL)isAlive;

@end
