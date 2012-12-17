//
//  GameLayer.h
//  LD20
//
//  Created by tomek on 5/1/11.
//

#import "cocos2d.h"

@class StarLayer, BattlefieldManager;


@interface GameLayer : CCLayer {
    StarLayer* starLayer;
    BattlefieldManager* battlefield;
    CCLabelTTF* scoreLbl;
    CCSprite* liveIndicator;
}

+ (CCScene *)scene;

@end
