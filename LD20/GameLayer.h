//
//  GameLayer.h
//  LD20
//
//  Created by tomek on 5/1/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "cocos2d.h"

@class StarLayer, Player;
@interface GameLayer : CCLayer {
    CCSprite* bullet;
    CCSprite* ufok1;
    Player* player;
    StarLayer* starLayer;
}

+(CCScene *) scene;

@end
