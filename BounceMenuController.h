//
//  BounceMenuController.h
//  BounceExample
//
//  Created by Benjamin Vogelzang on 9/25/13.
//  Copyright (c) 2013 Ben Vogelzang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BounceMenuController : UIViewController

@property (nonatomic, retain) NSArray *viewControllers;
@property (nonatomic, retain) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, retain) UIColor *menuButtonColor;

@end
