//
//  HelloWorldLayer.m
//  LD20
//
//  Created by tomek on 5/1/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


#import "HelloWorldLayer.h"

@implementation HelloWorldLayer

CCSprite* player;
CCSprite* bullet;
CCSprite* ufok1;


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)loadLevel {
    // player
    player = [CCSprite spriteWithFile:@"player.png"];
    player.position = CGPointMake(100, 100);
    player.scale = 0.5f;
    [self addChild:player];
    
    // bullet
    bullet = [CCSprite spriteWithFile:@"bullet.png"];
    bullet.position = CGPointMake(200, 100);
    bullet.scale = 0.5;
    [self addChild:bullet];
    
    // enemy 
    ufok1 = [CCSprite spriteWithFile:@"ufok1.png"];
    ufok1.position = CGPointMake(200, 300);
    ufok1.scale = 0.5;
    [self addChild:ufok1];
}

-(id) init
{
	if( (self=[super init])) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
        
        [self loadLevel];
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}
@end
