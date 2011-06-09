//
//  Util.h
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"


@interface Util : NSObject {
    
}

- (CCSprite*)createRetainSpriteWithFName:(NSString*)fname onLayer:(CCLayer*)layer withPos:(CGPoint)pos andZOrder:(int)zOrder;
+ (Util*)getInstance;

@end
