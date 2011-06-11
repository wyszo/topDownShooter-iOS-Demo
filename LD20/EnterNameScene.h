//
//  EnterNameScene.h
//  LD20
//
//  Created by tomek on 6/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"


@class CCUIViewWrapper;
@interface EnterNameScene : CCLayer {
    UIView* view;
    CCUIViewWrapper* viewWrapper;
}

+(CCScene*) scene;

@end
