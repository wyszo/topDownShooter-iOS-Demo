//
//  EnterNameScene.m
//  LD20
//
//  Created by tomek on 6/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EnterNameScene.h"
#import "CCUIViewWrapper.h"
#import "EnterNameUIViewController.h"


@implementation EnterNameScene

+ (CCScene *) scene {
    CCScene* scene = [CCScene node];
    
    EnterNameScene* layer = [EnterNameScene node];
    [scene addChild:layer];
    
    return scene; 
}

- (void)addUIView {
    enterNameVC = [[EnterNameUIViewController alloc] init];
    view = enterNameVC.view;
    viewWrapper = [CCUIViewWrapper wrapperForUIView:view];
    [self addChild:viewWrapper];
}

- (id)init {
    if ((self = [super init])) {
        
        // self.isTouchEnabled = YES;
        [self addUIView];
    }
    return self;
}

- (void)dealloc {
    [self removeChild:viewWrapper cleanup:YES];
    viewWrapper = nil;
    
    [view release];
    [super dealloc];
}

@end
