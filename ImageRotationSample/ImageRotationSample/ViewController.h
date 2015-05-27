//
//  ViewController.h
//  ImageRotationSample
//
//  Copyright (c) 2015 My Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageToMove;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;

- (IBAction)onButtonPress:(id)sender;

@end

