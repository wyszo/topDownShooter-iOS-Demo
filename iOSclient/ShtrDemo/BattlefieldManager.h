//
//  BulletManager.h
//  LD20
//
//  Created by tomek on 6/9/11.
//

#import "cocos2d.h"
@class Player;


@interface BattlefieldManager : NSObject {
    Player* player;
    CCLayer* canvasLayer;
    
    NSMutableArray* playerBullets;
    NSMutableArray* enemyBullets;
    NSMutableArray* enemies;
}

@property (nonatomic,retain) Player* player; 

- (id)initOnLayer:(CCLayer *)layer;
- (void)resetState;
- (void)nextFrame:(ccTime)deltaTime;
- (void)userTappedAtPoint:(CGPoint)point;

@end
