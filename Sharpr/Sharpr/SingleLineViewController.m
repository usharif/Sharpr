#import "SingleLineViewController.h"

#import "MyCertificate.h"

@implementation SingleLineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Register MyScript certificate before anything else
    NSData *certificate = [NSData dataWithBytes:myCertificate.bytes length:myCertificate.length];
    _certificateRegistered = [_singleLineWidget registerCertificate:certificate];
    
    if(_certificateRegistered)
    {
        _singleLineWidget.delegate = self;
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *bundlePath = [mainBundle pathForResource:@"resources" ofType:@"bundle"];
        bundlePath = [bundlePath stringByAppendingPathComponent:@"conf"];
        
        [_singleLineWidget addSearchDir:bundlePath];
        
        // The configuration is an asynchronous operation. Callbacks are provided to
        // monitor the beginning and end of the configuration process.
        //
        // "en_US" references the en_US bundle name in the conf/en_US.conf file in your resources.
        // "cur_text" references the configuration name in en_US.conf
        [_singleLineWidget configureWithBundle:@"en_US" andConfig:@"cur_text"];
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

- (void)singleLineWidget:(SLTWSingleLineWidget *)sender didConfigureWithSuccess:(BOOL)success
{
    if(!success)
    {
        NSLog(@"Unable to configure the Single Line Widget: %@", sender.errorString);
        return;
    }
    
    NSLog(@"Single Line Widget configured!");
}

- (void)singleLineWidget:(SLTWSingleLineWidget *)sender didChangeText:(NSString *)text intermediate:(BOOL)intermediatete
{
    NSLog(@"Single Line Widget text changed: %@", text);
}

@end
