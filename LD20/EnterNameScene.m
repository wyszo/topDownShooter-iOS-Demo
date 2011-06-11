//
//  EnterNameScene.m
//  LD20
//
//  Created by tomek on 6/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EnterNameScene.h"
#import "CCUIViewWrapper.h"


@implementation EnterNameScene

+(CCScene*) scene {
    CCScene* scene = [CCScene node];
    
    EnterNameScene* layer = [EnterNameScene node];
    [scene addChild:layer];
    
    return scene; 
}

- (void)addUIView {
    view = [[UIView alloc] init];
        
        UILabel* lbl = [[UILabel alloc] init];
        lbl.text = @"bla";
        lbl.frame = CGRectMake(0, 0, 200, 200);
        [view addSubview:lbl];
    
    viewWrapper = [CCUIViewWrapper wrapperForUIView:view];
    // viewWrapper.contentSzie = ;
    // viewWrapper.position = ;
    [self addChild:viewWrapper];
}

- (id)init {
    if ((self = [super init])) {
        
        self.isTouchEnabled = YES;
        
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

#pragma mark - touch dispatch

- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    
    // TODO: ... 
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    // [sprite runAction:[CCMoveTo actionWithDuration:1 position:location]];
}

@end
