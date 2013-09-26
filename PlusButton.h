//
//  PlusButton.h
//  BounceExample
//
//  Created by Benjamin Vogelzang on 9/25/13.
//  Copyright (c) 2013 Ben Vogelzang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlusButton : UIControl

@property (nonatomic, retain) UIColor *color;

- (void)showClose;
- (void)showOpen;

@end
