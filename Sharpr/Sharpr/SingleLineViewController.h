// Copyright MyScript. All rights reserved.

#import <ATKSingleLineWidget/SLTWSingleLineWidget.h>
#import <ATKSingleLineWidget/SLTWSingleLineWidgetDelegate.h>

@interface SingleLineViewController : UIViewController <SLTWSingleLineWidgetDelegate>

@property (strong, nonatomic) IBOutlet SLTWSingleLineWidget *singleLineWidget;
@property (assign, nonatomic) BOOL certificateRegistered;

@end
