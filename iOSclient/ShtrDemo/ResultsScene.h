//
//  DeathScene.h
//  LD20
//
//  Created by tomek on 6/10/11.
//

#import "cocos2d.h"
#import "HTTPConnectionDelegate.h"


@interface ResultsScene : CCLayer <HTTPConnectionDelegate> {
}

+ (CCScene *)scene;
+ (void)pushResultsScreen;
+ (void)setScore:(double)aScore;
- (void)updateWithHighscores:(NSArray*)highscores;

@end
