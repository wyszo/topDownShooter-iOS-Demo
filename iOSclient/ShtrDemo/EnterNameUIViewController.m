//
//  EnterNameUIViewController.m
//  LD20
//
//  Created by tomek on 6/11/11.
//

#import "EnterNameUIViewController.h"
#import "cocos2d.h"
#import "GameLayer.h"
#import "Util.h"


@implementation EnterNameUIViewController
@synthesize nameTF, customServerTF;

- (id)init {
    self = [super initWithNibName:@"EnterNameUIViewController" bundle:nil];
    if (self) {
        // [customServerTF setPlaceholder:(NSString*)DEFAULT_SERVER_ADDR];
    }
    return self;
}

- (void)dealloc
{
    [customServerTF release];
    [nameTF release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - IBactions

- (IBAction)loginAndDeploy {
    if ([nameTF.text length])
        PLAYER_NAME = nameTF.text;
    
    CCScene* nextScene = [GameLayer scene];      
    [[CCDirector sharedDirector] replaceScene:nextScene];    
}

@end
