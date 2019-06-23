//
//  AppDelegate.m
//  Flipr
//
//  Created by Adem Atalay on 20.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "AppDelegate.h"
#import "FLCoordinator.h"

@interface AppDelegate ()

@property (nonatomic) FLCoordinator *coordinator;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _coordinator = FLCoordinator.new;
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = _coordinator.startupViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
