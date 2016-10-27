//
//  ViewController.h
//  MathWidgetTest
//
//  Copyright © 2016 MyScript. All rights reserved.
//

#import <ATKMathWidget/MAWMathWidget.h>

@interface ViewController : UIViewController <MAWMathViewDelegate>

@property (strong, nonatomic) IBOutlet MAWMathView *mathView;
@property (assign, nonatomic) BOOL certificateRegistered;

@end
