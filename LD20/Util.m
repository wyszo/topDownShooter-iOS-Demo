//
//  Util.m
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Util.h"


@implementation Util
@synthesize score = _score;

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

- (void)setScore:(int)score {
    _score = score;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scoreUpdated" object:self];
}

+ (BOOL)pointWithX:(double)x y:(double)y colidedWithObjectWithX:(double)objX y:(double)objY width:(double)objWidth andHeight:(double)objHeight {
    BOOL result = NO;
    
    // sprawdzenie  wysokości
    if (y > objY && y < objY + objHeight) 
        // sprawdzenie szerokości                
        if (x > objX && x < objX + objWidth) 
            result = YES;
    return result;
}

@end
