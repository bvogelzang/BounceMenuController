## BounceMenuController

BounceMenuController is a tab bar controller-esque navigation solution for iOS inspired by [Creativedash](http://dribbble.com/shots/1248375-Bounce-Menu-CSS). An elegant and minimal alternative to UITabBarController.

![Animation](https://raw.github.com/bvogelzang/BounceMenuController/master/example.gif)

Contributions are welcomed. Feel free to let me know of any bugs you may experience as this has not been used in a production setting. Pull requests are the preferred way to contribute.

## Usage

**Installation with CocoaPods**

```objective-c
platform :ios, '7.0'
pod 'BounceMenuController', '~> 0.0.1'
```

**Otherwise**

Add `BounceMenuController.h`, `BouceMenuController.m`, `PlusButton.h`, and `PlusButton.m` files to your project and add the QuartzCore framework to your project.

**Initializing and using the BounceMenuController**

```objective-c
BounceMenuController *bounceMenuController = [[BounceMenuController alloc] init];

// load view controllers from a storyboard
UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StoryboardiPhone" bundle:nil];
UIViewController *vc1 = [sb instantiateViewControllerWithIdentifier:@"ViewController1"];
UIViewController *vc2 = [sb instantiateViewControllerWithIdentifier:@"ViewController2"];
UIViewController *vc3 = [sb instantiateViewControllerWithIdentifier:@"ViewController3"];

// set the view controllers for the bounce menu
NSArray *controllers = [NSArray arrayWithObjects:vc1, vc2, vc3, nil];
bounceMenuController.viewControllers = controllers;
```

**Any view controller used with BounceMenuController must have its UITabBarItem image set. The image(s) can also be set in your storyboard file.**

```objective-c
viewController.tabBarItem.image = [UIImage imageNamed:@"tabBarImage.png"];
```

**You can also customize the background and menu button colors**

```objective-c
bounceMenuController.backgroundColor = [UIColor blackColor]
bounceMenuController.menuButtonColor = [UIColor lightGrayColor];
```

## Known Issues

1. When the device is rotated, tabs that have already been accessed will jump into position when selected instead of properly animating.
2. If there are more tabs than vertical space allows (in landscape or otherwise), those tabs cannot be accessed.
3. A delegate property should be added so a delegate can be notified of when a view controller is selected.

## Requirements

BounceMenuController requires iOS 5.0 and above.

#### ARC

BounceMenuController uses ARC as of its 1.0 release.

## License

Made available under the MIT License. Attribution would be nice.

