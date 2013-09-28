//
//  AppDelegate.h
//  BounceExample
//
//  Created by Benjamin Vogelzang on 9/25/13.
//  Copyright (c) 2013 Ben Vogelzang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BounceMenuController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, BounceMenuControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
