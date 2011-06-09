//
//  GameLayer.h
//  LD20
//
//  Created by tomek on 5/1/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "cocos2d.h"

@class StarLayer, BattlefieldManager;
@interface GameLayer : CCLayer {
    StarLayer* starLayer;
    BattlefieldManager* battlefield;
}

+(CCScene *) scene;

@end
