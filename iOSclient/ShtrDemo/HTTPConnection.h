//
//  HTTPConnectionDelegate.h
//  LD20
//
//  Created by tomek on 6/10/11.
//

#import "cocos2d.h"
#import "HTTPConnectionDelegate.h"


@interface HTTPConnection : NSObject {
    NSMutableData* receivedData;
}

@property (nonatomic, retain) NSObject<HTTPConnectionDelegate>* delegate;

+ (HTTPConnection *)getInstance;
+ (void)sendSimplePostRequest;

@end
