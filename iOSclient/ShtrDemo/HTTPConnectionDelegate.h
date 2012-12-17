//
//  HTTPConnectionDelegate.h
//  LD20
//
//  Created by tomek on 6/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


@protocol HTTPConnectionDelegate <NSObject>
- (void)updateWithHighscores:(NSArray *)highscores;
@end
