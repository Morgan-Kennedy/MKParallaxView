//
//  MKView.h
//  MKParallaxViewDemo
//
//  Created by Morgan Kennedy on 21/07/13.
//  Copyright (c) 2013 Morgan Kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKParallaxView.h"

@interface MKView : UIView

/**
 Test 1 Parallax View using a normal image
 */
@property (nonatomic, strong) MKParallaxView *parallaxView1;

/**
 Test 2 Parallax View using a background repeat pattern
 */
@property (nonatomic, strong) MKParallaxView *parallaxView2;

@end
