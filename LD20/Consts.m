//
//  Consts.m
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Consts.h"
#import "cocos2d.h"


@implementation Consts
@synthesize screenCenter, STAR_LAYER0_SPEED, STAR_LAYER1_SPEED, STAR_LAYER_1_SPEED, STAR_LAYER_2_SPEED;


static Consts* instance;

+ (Consts*)getInstance {
    @synchronized(self) {
        if (instance == NULL)
            instance = [[Consts alloc] init];
    }
    return instance; 
}

- (void)initVariables {

    CGSize size = [[CCDirector sharedDirector] winSize];
    screenCenter = CGPointMake(size.width/2, size.height/2);

    STAR_LAYER_2_SPEED = -60.0;
    STAR_LAYER_1_SPEED = -70.0;
    STAR_LAYER0_SPEED = -100.0;
    STAR_LAYER1_SPEED = -130.0;
    
}

- (id)init {
    if ((self = [super init])) {
        [self initVariables];
    }
    return self;
}

@end
