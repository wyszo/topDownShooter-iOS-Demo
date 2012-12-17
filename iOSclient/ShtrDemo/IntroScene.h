//
//  IntroScene.h
//  LD20
//
//  Created by tomek on 5/1/11.
//

#import "cocos2d.h"


@interface IntroScene : CCLayer {
}

- (void)showIntroViewWithSprite:(CCSprite *)introView;
+ (CCScene *)scene;

@end
