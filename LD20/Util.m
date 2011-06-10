//
//  Util.m
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Util.h"


@implementation Util

static Util* instance;

+ (Util*)getInstance {
    @synchronized(self) {
        if (instance == NULL) {
            instance = [[Util alloc] init];
        }        
    }
    return instance; 
}

- (CCSprite*)createRetainSpriteWithFName:(NSString*)fname onLayer:(CCLayer*)layer withPos:(CGPoint)pos andZOrder:(int)zOrder {
    
    CCSprite* newSprite = [CCSprite spriteWithFile:fname];
    [newSprite retain];
    [layer addChild:newSprite z:zOrder];
    newSprite.position = pos;
    
    return newSprite;
}



@end
