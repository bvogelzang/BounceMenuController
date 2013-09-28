//
//  BounceMenuController.m
//  BounceExample
//
//  Created by Benjamin Vogelzang on 9/25/13.
//  Copyright (c) 2013 Ben Vogelzang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BounceMenuController.h"
#import "PlusButton.h"

@interface BounceMenuController ()

@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) PlusButton *menuButton;
@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, retain) UITapGestureRecognizer *contentTap;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL isAnimating;

- (void)openMenu;
- (void)closeMenu;

@end

@implementation BounceMenuController


@synthesize viewControllers = _viewControllers;
@synthesize selectedViewController = _selectedViewController;
@synthesize selectedIndex = _selectedIndex;

@synthesize delegate;

@synthesize backgroundColor = _backgroundColor;
@synthesize menuButtonColor = _menuButtonColor;

@synthesize contentView = _contentView;
@synthesize menuButton = _menuButton;
@synthesize buttons = _buttons;
@synthesize contentTap = _contentTap;
@synthesize isOpen = _isOpen;
@synthesize isAnimating = _isAnimating;



- (id)init
{
    self = [super init];
    if (self) {
        _viewControllers = [NSArray array];
        _selectedViewController = nil;
        _selectedIndex = 0;
        _isOpen = NO;
        _isAnimating = NO;
        _buttons = [NSMutableArray array];
        
        self.view.backgroundColor = [UIColor colorWithRed:0.13f green:0.13f blue:0.13f alpha:1.00f];
        
        self.menuButton = [[PlusButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [self.menuButton addTarget:self action:@selector(menuButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.menuButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews {
    self.menuButton.frame = CGRectMake(15, self.view.bounds.size.height - 45, self.menuButton.frame.size.width, self.menuButton.frame.size.height);
    
    for (UIViewController *viewController in self.viewControllers) {
        viewController.view.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    
    CGFloat buttonStartY = self.view.bounds.size.height - 100;
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *button = [self.buttons objectAtIndex:i];
        CGFloat buttonY = buttonStartY - (i * 50);
        button.frame = CGRectMake(15, buttonY, 30, 30);
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.selectedViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.selectedViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setViewControllers:(NSArray *)theViewControllers {
    _viewControllers = theViewControllers;
    
    // use the selected index
    self.selectedViewController = [self.viewControllers objectAtIndex:self.selectedIndex];
}

- (void)setSelectedViewController:(UIViewController *)theSelectedViewController {
    _selectedViewController = theSelectedViewController;
    _selectedIndex = [self.viewControllers indexOfObject:theSelectedViewController];
    
    [self.contentView removeFromSuperview];
    self.contentView = self.selectedViewController.view;
    self.contentView.bounds = self.view.bounds;
    [self.view insertSubview:self.contentView belowSubview:self.menuButton];
}

- (void)setSelectedIndex:(NSUInteger)theSelectedIndex {
    _selectedIndex = theSelectedIndex;
    
    // use the selected index
    self.selectedViewController = [self.viewControllers objectAtIndex:theSelectedIndex];
}

- (void)setBackgroundColor:(UIColor *)theBackgroundColor {
    _backgroundColor = theBackgroundColor;
    self.view.backgroundColor = theBackgroundColor;
}

- (void)setMenuButtonColor:(UIColor *)theMenuButtonColor {
    _menuButtonColor = theMenuButtonColor;
    self.menuButton.color = theMenuButtonColor;
}

- (void)menuButtonTapped:(UIButton *)menuButton {
    if (!self.isAnimating) {
        if (self.isOpen) {
            [self closeMenu];
        }
        else {
            [self openMenu];
        }
    }
}

- (void)controllerSelected:(UIButton *)button {

    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(bouncMenuController:shouldSelectViewController:)]) {
        BOOL shouldSelect = [self.delegate bouncMenuController:self shouldSelectViewController:self.selectedViewController];
        if (!shouldSelect) {
            [self closeMenu];
            return;
        }
    }
    
    if (button.tag != self.selectedIndex) {
        _selectedViewController = [self.viewControllers objectAtIndex:button.tag];
        _selectedIndex = button.tag;
        
        self.selectedViewController.view.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
        [self.view insertSubview:self.selectedViewController.view belowSubview:self.menuButton];
        [self.contentView removeFromSuperview];
        self.contentView = self.selectedViewController.view;
        
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(bouncMenuController:didSelectViewController:)]) {
            [self.delegate bouncMenuController:self didSelectViewController:self.selectedViewController];
        }
    }
    
    [self closeMenu];
}

- (void)viewTapped:(UITapGestureRecognizer *)tap {
    
    if (self.isOpen && !self.isAnimating) {
        CGPoint touchPoint = [tap locationInView:self.view];
        if (CGRectContainsPoint(self.contentView.frame, touchPoint))
            [self closeMenu];
    }
}

- (void)openMenu {
    
    self.isAnimating = YES;
    
    // create all of the buttons for each of the view controllers
    CGFloat buttonStartY = self.view.bounds.size.height - 100;
    
    for (int i = 0; i < self.viewControllers.count; i++) {
        
        UIViewController *viewController = [self.viewControllers objectAtIndex:i];
        
        NSAssert(viewController.tabBarItem.image != nil, @"A view controller used with BounceMenuController does not have its tab bar image set %@. Any view controller used with BounceMenuController must have its UITabBarItem image set e.g. viewController.tabBarItem.image = [UIImage imageNamed:\u0040\"tabBarImage.png\"]", viewController);
        
        // create the button
        UIButton *controllerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [controllerButton setImage:viewController.tabBarItem.image forState:UIControlStateNormal];
        controllerButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        controllerButton.adjustsImageWhenHighlighted = NO;
        controllerButton.layer.opacity = 0.0;
        controllerButton.tag = i;
        
        // show which view controller is currently selected
        if (i == self.selectedIndex) {
            [controllerButton setEnabled:NO];
        }
        
        // find offset from center of buttons
        // this is used to give a "converging" effect when animating in the buttons
        CGFloat buttonY = buttonStartY - (i * 50);
        int midPoint = self.viewControllers.count * 0.5;
        int offset = i - midPoint;
        controllerButton.frame = CGRectMake(-40, buttonY - (offset * 20), 30, 30);
        
        [controllerButton addTarget:self action:@selector(controllerSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.buttons addObject:controllerButton];
        [self.view insertSubview:controllerButton belowSubview:self.contentView];
        
        // move and fade the button into view
        CGRect finalFrame = controllerButton.frame;
        finalFrame.origin = CGPointMake(15, buttonY);
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            controllerButton.frame = finalFrame;
        }
        completion:nil];
        
        [UIView animateWithDuration:0.3 delay:0.1 options:kNilOptions animations:^{
            controllerButton.layer.opacity = 1.0;
        }
        completion:nil];
    }
    
    
    // animate the view and menu button
    [self.menuButton showClose];
    self.isOpen = YES;
    
    self.contentView.userInteractionEnabled = NO;
    self.contentTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    self.contentTap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:self.contentTap];
    
    CGRect openedPosition = self.contentView.frame;
    openedPosition.origin = CGPointMake(70, -70);
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
         self.contentView.frame = openedPosition;
    }
    completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.contentView.frame = CGRectOffset(openedPosition, -10, 10);
        }
        completion:^(BOOL finished) {
            self.isAnimating = NO;
        }];
    }];
}


- (void)closeMenu {
    
    self.isAnimating = YES;
    
    [self.menuButton showOpen];
    self.isOpen = NO;
    
    self.contentView.userInteractionEnabled = YES;
    [self.view removeGestureRecognizer:self.contentTap];
    
    CGRect closedPosition = self.contentView.frame;
    closedPosition.origin = CGPointMake(0, 0);
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.contentView.frame = closedPosition;
    }
    completion:^(BOOL finished) {
        // remove all the buttons
        for (UIButton *button in self.buttons) {
            [button removeFromSuperview];
        }
        [self.buttons removeAllObjects];
        
        self.isAnimating = NO;
    }];
}



@end
