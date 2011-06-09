//
//  Consts.h
//  LD20
//
//  Created by tomek on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define screenCenter_X [[Consts getInstance] screenCenter].x
#define screenCenter_Y [[Consts getInstance] screenCenter].y

static const float BULLET_SPEED = 90;


@interface Consts : NSObject {
}

@property(nonatomic) CGPoint screenCenter;

// star layers velocities
@property(nonatomic) float STAR_LAYER_2_SPEED;
@property(nonatomic) float STAR_LAYER_1_SPEED;
@property(nonatomic) float STAR_LAYER0_SPEED;
@property(nonatomic) float STAR_LAYER1_SPEED;

+ (Consts*)getInstance;

@end
