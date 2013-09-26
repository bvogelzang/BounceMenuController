//
//  PlusButton.m
//  BounceExample
//
//  Created by Benjamin Vogelzang on 9/25/13.
//  Copyright (c) 2013 Ben Vogelzang. All rights reserved.
//

#import "PlusButton.h"

@interface PlusButton ()

@property (nonatomic, retain) UIView *verticalView;
@property (nonatomic, retain) UIView *horizontalView;

@end

@implementation PlusButton

@synthesize color;

@synthesize verticalView;
@synthesize horizontalView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSInteger lineWeight = 4;
        
        self.horizontalView = [[UIView alloc] initWithFrame:CGRectMake(0, (frame.size.height * 0.5) - (lineWeight * 0.5), frame.size.width, lineWeight)];
        self.horizontalView.backgroundColor = [UIColor whiteColor];
        self.horizontalView.userInteractionEnabled = NO;
        [self addSubview:self.horizontalView];
        
        self.verticalView = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width * 0.5) - (lineWeight * 0.5), 0, lineWeight, frame.size.height)];
        self.verticalView.backgroundColor = [UIColor whiteColor];
        self.verticalView.userInteractionEnabled = NO;
        [self addSubview:self.verticalView];
    
    }
    return self;
}

- (void)setColor:(UIColor *)theColor {
    color = theColor;
    
    self.horizontalView.backgroundColor = theColor;
    self.verticalView.backgroundColor = theColor;
}

- (void)showClose {
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.verticalView.frame = CGRectMake(self.verticalView.frame.origin.x, self.frame.size.height * 0.5, self.verticalView.frame.size.width, 0);
        self.horizontalView.frame = CGRectMake(-5, self.horizontalView.frame.origin.y, self.frame.size.width + 10, self.horizontalView.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.horizontalView.frame = CGRectMake(0, self.horizontalView.frame.origin.y, self.frame.size.width, self.horizontalView.frame.size.height);
        } completion:nil];
    }];
}

- (void)showOpen {
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.verticalView.frame = CGRectMake(self.verticalView.frame.origin.x, 0, self.verticalView.frame.size.width, self.frame.size.height);
        self.horizontalView.frame = CGRectMake(5, self.horizontalView.frame.origin.y, self.frame.size.width - 10, self.horizontalView.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.horizontalView.frame = CGRectMake(0, self.horizontalView.frame.origin.y, self.frame.size.width, self.horizontalView.frame.size.height);
        } completion:nil];
    }];
}

@end
