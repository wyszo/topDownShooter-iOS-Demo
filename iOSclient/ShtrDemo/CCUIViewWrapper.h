//
//  CCUIViewWrapper.h
//  LD20
//
//  Created by tomek on 6/11/11.
//

#import "cocos2d.h"


@interface CCUIViewWrapper : CCSprite
{
	UIView *uiItem;
	float rotation;
}

@property (nonatomic, retain) UIView *uiItem;

+ (id) wrapperForUIView:(UIView*)ui;
- (id) initForUIView:(UIView*)ui;

- (void) updateUIViewTransform;

@end
