//
//  EnterNameUIViewController.h
//  LD20
//
//  Created by tomek on 6/11/11.
//

#import <UIKit/UIKit.h>


@interface EnterNameUIViewController : UIViewController {
}

@property (nonatomic, retain) IBOutlet UITextField* nameTF;
@property (nonatomic, retain) IBOutlet UITextField* customServerTF;

- (IBAction)loginAndDeploy;

@end
