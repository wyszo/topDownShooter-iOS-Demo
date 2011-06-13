//
//  Consts.m
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Consts.h"
#import "cocos2d.h"


const NSString* DEFAULT_SERVER_ADDR = @"http://wyszo.dyndns.org";


@implementation Consts
@synthesize screenCenter, windowSize, canvasLayer;

static Consts* instance;

+ (Consts*)getInstance {
    @synchronized(self) {
        if (instance == NULL)
            instance = [[Consts alloc] init];
    }
    return instance; 
}

- (void)initVariables {
    
    windowSize = [[CCDirector sharedDirector] winSize];
    screenCenter = CGPointMake(windowSize.width/2, windowSize.height/2);
}

- (id)init {
    if ((self = [super init])) {
        [self initVariables];
    }
    return self;
}

- (void)dealloc {
    [canvasLayer release];
    [super dealloc];
}

@end
