//
//  DeathScene.h
//  LD20
//
//  Created by tomek on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"


@interface ResultsScene : CCLayer {
    
}

+(CCScene*) scene;
+(void) pushResultsScreen;
+(void) setScore:(double)aScore;

@end
