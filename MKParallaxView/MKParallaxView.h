//
//  MKParallaxView.h
//  MKParallaxViewDemo
//
//  Created by Morgan Kennedy on 19/07/13.
//  Copyright (c) 2013 Morgan Kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKParallaxView : UIView

/**
 The image to be set as the background which will shift with the gyro
 */
@property (nonatomic, strong) UIImage *backgroundImage;

/**
 By default it is set to NO (no repeat)
 If YES then the bacground image will automatically repeat (great for a pattern image)
 */
@property (nonatomic, assign) BOOL backgroundShouldRepeat;

/**
 The rate at which the parallax view updates itself 
 (think of it like frames per second)
 Default is 60
 */
@property (nonatomic, assign) NSInteger updateRate;

@end
