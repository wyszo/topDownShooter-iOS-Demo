//
//  Util.m
//  LD20
//
//  Created by tomek on 6/9/11.
//

#import "Util.h"
#import "Settings.h"


@implementation Util
@synthesize score = _score;
@synthesize playerName, customServerAddr;

static Util* instance;

+ (Util *)getInstance {
    @synchronized(self) {
        if (instance == NULL) {
            instance = [[Util alloc] init];
            PLAYER_NAME = @"anonymous pilot";
        }
    }
    return instance; 
}

+ (NSString*)getServerAddress {
    NSString* result = CUSTOM_SERVER_ADDR;
    if ([result length] == 0)
        result = [NSString stringWithString:(NSString*)kNetwork_DefaultServerAddr];
    return result;
}

- (void)dealloc {
    [customServerAddr release];
    [playerName release];
    [super dealloc];
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
    
    // check height
    if (y > objY && y < objY + objHeight)
        // check width
        if (x > objX && x < objX + objWidth) 
            result = YES;
    return result;
}

/**
 * @param coef
 *      0 <= coef <= 1
 */
+ (CGRect)scaleRect:(CGRect)rect by:(double)coef {
    CGRect result = rect;
    
    result.origin.x = rect.origin.x + (rect.size.width * (1-coef) * 0.5);
    result.origin.y = rect.origin.y + (rect.size.height * (1-coef) * 0.5);
    result.size.width *= coef;
    result.size.height *= coef;
    
    return result;
}

/**
 * @param tolerance 
 *      Scale coefficient for sprite scalling before checking collision
 */
+ (BOOL)sprite:(CCSprite*)spr1 collidesWithSprite:(CCSprite*)spr2 withTolerance:(float)tolerance {
    CGRect rect1 = spr1.textureRect; 
    rect1.origin = spr1.position;
    
    CGRect rect2 = spr2.textureRect;
    rect2.origin = spr2.position;
    
    // apply tolerance
    rect1 = [Util scaleRect:rect1 by:(1-tolerance)];
    rect2 = [Util scaleRect:rect2 by:(1-tolerance)];
    
    // check collision
    BOOL result = CGRectIntersectsRect(rect1, rect2);
    return result;
}

@end
