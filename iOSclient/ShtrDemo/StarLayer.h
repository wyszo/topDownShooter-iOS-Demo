//
//  StarLayer.h
//  LD20
//
//  Created by tomek on 6/9/11.
//

#import "cocos2d.h"


@interface StarLayer : NSObject {
}

- (id)initOnLayer:(CCLayer*)layer;
- (void)animateStarsWithDeltaTime:(ccTime)dt;

@end
