//
//  EnterNameScene.h
//  LD20
//
//  Created by tomek on 6/11/11.
//

#import "cocos2d.h"
@class CCUIViewWrapper, EnterNameUIViewController;


@interface EnterNameScene : CCLayer {
    UIView* view;
    EnterNameUIViewController* enterNameVC;
    CCUIViewWrapper* viewWrapper;
}

+ (CCScene*)scene;

@end
