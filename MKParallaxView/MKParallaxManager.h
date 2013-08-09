//
//  MKParallaxManager.h
//  MKParallaxViewDemo
//
//  Created by Morgan Kennedy on 19/07/13.
//  Copyright (c) 2013 Morgan Kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 MKParallaxManager is in charge of all calculations relating to the parallax effect
 */
@class MKParallaxManager;

@interface MKParallaxManager : NSObject

/**
 Returns an inited instace of the parallax manager to work with
 @return standardParallaxManager The standard parallax manager
 */
+ (MKParallaxManager *)standardParallaxManager;

/**
 Generates a parallex position (frame) from a view frame (that it sits in), 
 and the current pitch and roll
 @param viewFrame is the Frame of the whole parallax view
 @return the frame that the image should be moving to
 */
- (CGRect)parallexFrameWithViewFrame:(CGRect)viewFrame;

@end
