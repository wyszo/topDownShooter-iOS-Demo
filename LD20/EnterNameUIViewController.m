//
//  EnterNameUIViewController.m
//  LD20
//
//  Created by tomek on 6/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EnterNameUIViewController.h"
#import "cocos2d.h"
#import "GameLayer.h"
#import "Util.h"


@implementation EnterNameUIViewController
@synthesize nameTF;

- (id)initW
{
    self = [super initWithNibName:@"EnterNameUIViewController" bundle:nil];
    if (self) {

    }
    return self;
}

- (void)dealloc
{
    [nameTF release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - IBactions

-(IBAction)loginAndDeploy {
    if ([nameTF.text length])
        PLAYER_NAME = nameTF.text;
    
    CCScene* nextScene = [GameLayer scene];      
    [[CCDirector sharedDirector] replaceScene:nextScene];    
}

@end
