# image-rotation-sample
An example project for iOS image view rotation (project built for iOS 8 and Xcode 6.3)

Based on the Stack Overflow question [answered here](http://stackoverflow.com/a/11242492/119114)

The relevant class to inspect is the [ViewController](https://github.com/n8r0n/image-rotation-sample/blob/master/ImageRotationSample/ImageRotationSample/ViewController.m).  In it, you will find the start/stop button action for the sample app's UI:

<!-- language-all: lang-objc -->

    - (IBAction)onButtonPress:(id)sender;


This method will toggle between calling

    - (void) stopLogoSpin;

and

    - (void) startLogoSpin;

`ViewController` ivars are not protected, so it is assumed that all calls in this class are made on the main thread.

The ivars maintain state, and the image animation moves to a `animationCompleting` state before ending, to let the animation wind down smoothly.  This class supports calling `startLogoSpin` immediately after callling `stopLogoSpin`, in case a new spin is initiated before the rotation of the previous spin completely finishes.

If the client code needs to use this, for example, as a *progress indicator*, and parallel tasks will be stopping at starting at overlapping intervals, then additional client code is needed to determine when to stop the spinning, after the last parallel task completes (e.g. use a ref-counting scheme).
