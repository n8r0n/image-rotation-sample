//
//  ViewController.m
//  ImageRotationSample
//
//  Copyright (c) 2015 My Company. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
   BOOL animate;
   BOOL animationCompleting;
   BOOL animationPending;
}
@end

@implementation ViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

#pragma mark - Spinning

- (void) spinLogoWithOptions: (UIViewAnimationOptions) options {
   NSTimeInterval fullSpinInterval = 5.0f;
   [UIView animateWithDuration: fullSpinInterval / 4.0f
                         delay: 0.0f
                       options: options
                    animations: ^{
                       self.imageToMove.transform = CGAffineTransformRotate(self.imageToMove.transform, M_PI / 2.0f);
                    }
                    completion:^(BOOL finished) {
                       // if flag still set, keep spinning with constant speed
                       if (animate) {
                          [self spinLogoWithOptions: UIViewAnimationOptionCurveLinear];
                       } else if (animationPending) {
                          // another spin has been requested, so start it right back up!
                          animationPending = NO;
                          animate = YES;
                          [self spinLogoWithOptions: UIViewAnimationOptionBeginFromCurrentState];
                       } else if ((options & UIViewAnimationOptionCurveEaseOut) == 0) {
                          // one last spin, with deceleration
                          [self spinLogoWithOptions: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut];
                       } else {
                          animationCompleting = NO;
                       }
                    }];
}

- (void) stopLogoSpin {
   animate = NO;
   animationCompleting = YES;
}

- (void) startLogoSpin {
   if (!animate) {
      if (animationCompleting) {
         animationPending = YES;
      } else {
         animate = YES;
         [self spinLogoWithOptions: UIViewAnimationOptionCurveEaseIn];
      }
   }
}

#pragma mark -

- (IBAction)onButtonPress:(id)sender {
   if ([self.startStopButton.titleLabel.text isEqualToString: @"Start"]) {
      [self.startStopButton setTitle: @"Stop" forState: UIControlStateNormal];
      [self startLogoSpin];
   } else {
      [self.startStopButton setTitle: @"Start" forState: UIControlStateNormal];
      [self stopLogoSpin];
   }
}

@end
