//
//  wifiConnectAppDelegate.h
//  wifiConnect
//
//  Created by apple on 10/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class wifiConnectViewController;

@interface wifiConnectAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    wifiConnectViewController *viewController;
}
- (void)doshowLoadingView;
- (void)hideLoadingView;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet wifiConnectViewController *viewController;

@end

