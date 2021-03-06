//
//  DeathScene.m
//  LD20
//
//  Created by tomek on 6/10/11.
//

#import "ResultsScene.h"
#import "Consts.h"
#import "Settings.h"
#import "HTTPConnection.h"

static int score;

@implementation ResultsScene

+ (CCScene *)scene {
    CCScene* scene = [CCScene node];
    
    ResultsScene* layer = [ResultsScene node];
    [scene addChild:layer];
    
    return scene;
}

+ (void)setScore:(double)aScore {
    score = aScore;
}

+ (void)pushResultsScreen {
    CCScene* resultsScene = [ResultsScene scene];
    [[CCDirector sharedDirector] pushScene:resultsScene];  
}

- (void)addLabelWithText:(NSString*)text size:(int)size onPosition:(CGPoint)pos {
    NSString* fontName = @"Marker Felt";
    
    CCLabelTTF* lbl = [CCLabelTTF labelWithString:text fontName:fontName fontSize:size];
    lbl.position = pos;
    [self addChild: lbl];
}

- (void)addScreenLabels {
    // Game Over
    double y = SCREEN_HEIGHT - GAME_OVER_LBL_Y_OFFSET;
    [self addLabelWithText:@"GameOver" size:GAME_OVER_LBL_SIZE onPosition:CGPointMake(SCREEN_WIDTH/2, y)];
    
    // Player Name
    y = SCREEN_HEIGHT - PLAYER_NAME_LBL_Y_OFFSET;
    [self addLabelWithText:PLAYER_NAME size:PLAYER_NAME_LBL_SIZE onPosition:CGPointMake(SCREEN_WIDTH/2, y)];
    
    // Your score
    y = SCREEN_HEIGHT - YOUR_SCORE_LBL_Y_OFFSET;
    [self addLabelWithText:[NSString stringWithFormat:@"Your score: %d",score] size:YOUR_SCORE_LBL_SIZE onPosition:CGPointMake(SCREEN_WIDTH/2, y)];
}

- (void)sendHttpFrame {
    // it'd be cool if server responded actual highscore list as a response for this dummy frame
    
    if (kSetting_NetworkEnabled) {
        [HTTPConnection getInstance].delegate = self;
        [HTTPConnection sendSimplePostRequest];        
    }
}

- (void)updateWithHighscores:(NSArray*)highscores {
    NSLog(@"highscores: %@", highscores);

    // Highscores
    double y = SCREEN_HEIGHT - HIGHSCORES_TITLE_LBL_Y_OFFSET;
    [self addLabelWithText:@"Highscores" size:HIGHSCORES_TITLE_LBL_SIZE onPosition:CGPointMake(SCREEN_WIDTH/2, y)];
    
    
    y = SCREEN_HEIGHT - HIGHSCORES_TITLE_LBL_Y_OFFSET - HIGHSCORES_TITLE_LIST_LBL_Y_OFFSET;
    
    for (int i=0; i<[highscores count]; i+=2) {
        // single item
        NSString* name = [highscores objectAtIndex:i];
        NSString* score = [highscores objectAtIndex:i+1];
     
        [self addLabelWithText:name size:HIGHSCORES_LBL_SIZE onPosition:CGPointMake(100, y)];

        [self addLabelWithText:score size:HIGHSCORES_LBL_SIZE onPosition:CGPointMake(SCREEN_WIDTH - 50, y)];    
        
        y -= HIGHSCORES_LBL_VERTICAL_OFFSET;
    }
}

- (id)init {
    if ((self = [super init])) {
        self.isTouchEnabled = YES;
     
        [self addScreenLabels];
        [self sendHttpFrame];
        SCORE = 0;
    }
    return self;
}

BOOL touchStarted;

#pragma mark - touch dispatch

- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    touchStarted = YES;
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    // CGPoint location = [self convertTouchToNodeSpace:touch];

    if (touchStarted)
        [[CCDirector sharedDirector] popScene];
}

@end
