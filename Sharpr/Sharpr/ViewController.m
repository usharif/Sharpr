//
//  ViewController.m
//  MathWidgetSample
//
//  Copyright © 2016 MyScript. All rights reserved.
//
#import "ViewController.h"

#import "MyCertificate.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Register MyScript certificate before anything else
    NSData  *certificate = [NSData dataWithBytes:myCertificate.bytes length:myCertificate.length];
    _certificateRegistered = [_mathView registerCertificate:certificate];
    
    if(_certificateRegistered)
    {
        // Register as delegate to be notified of configuration, recognition, ...
        _mathView.delegate = self;
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *bundlePath = [mainBundle pathForResource:@"resources" ofType:@"bundle"];
        bundlePath = [bundlePath stringByAppendingPathComponent:@"conf"];
        [_mathView addSearchDir:bundlePath];
        
        // The configuration is an asynchronous operation. Callbacks are provided to
        // monitor the beginning and end of the configuration process.
        //
        // "math" references the math bundle name in conf/math.conf file in your resources.
        // "standard" references the configuration name in math.conf
        [_mathView configureWithBundle:@"math" andConfig:@"standard"];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!_certificateRegistered)
    {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Invalid certificate"
                                              message:@"Please use a valid certificate."
                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleDefault
                                   handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)mathViewDidEndConfiguration:(MAWMathView *)mathView
{
    NSLog(@"Math Widget configured!");
}

- (void)mathView:(MAWMathView *)mathView didFailConfigurationWithError:(NSError *)error
{
    NSLog(@"Unable to configure the Math Widget: %@", [error localizedDescription]);
}

- (void)mathViewDidEndRecognition:(MAWMathView *)mathView
{
    NSLog(@"Math Widget recognition: %@", [mathView resultAsText]);
}

@end
