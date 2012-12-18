//
//  Explosion.m
//  LD20
//


#import "Explosion.h"
#import "Util.h"


@implementation Explosion

static float EXPLOSION_DURATION = 0.2;
static NSString *EXPLOSION_SPRITE_FNAME = @"explosion1.png";


- (id)initOnLayer:(CCLayer*)layer withZOrder:(int)ZOrder andPos:(CGPoint)pos {
    self = [super init];
    if (self) {
        expl = [[Util getInstance] createRetainSpriteWithFName:EXPLOSION_SPRITE_FNAME onLayer:layer withPos:pos andZOrder:ZOrder];
        
        // schedule destroySelf
        id action = [CCCallFunc actionWithTarget:self selector:@selector(destroySelf)];
        id delay = [CCDelayTime actionWithDuration:EXPLOSION_DURATION];
        [CANVAS runAction:[CCSequence actions:delay, action, nil]];
    }
    return self;
}

- (void)dealloc {
    [expl release];
    [super dealloc];
}

- (void)destroySelf {
    [expl removeFromParentAndCleanup:YES];
}

@end
