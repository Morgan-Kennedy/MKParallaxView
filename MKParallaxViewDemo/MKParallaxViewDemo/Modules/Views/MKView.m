//
//  MKView.m
//  MKParallaxViewDemo
//
//  Created by Morgan Kennedy on 21/07/13.
//  Copyright (c) 2013 Morgan Kennedy. All rights reserved.
//

#import "MKView.h"
#import "SQLayout.h"

@implementation MKView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _parallaxView1 = [[MKParallaxView alloc] initWithFrame:CGRectZero];
        _parallaxView1.backgroundImage = [UIImage imageNamed:@"blue-dots.jpg"];
        
        _parallaxView2 = [[MKParallaxView alloc] initWithFrame:CGRectZero];
        _parallaxView2.backgroundColor = [UIColor colorWithPatternImage:
                                          [UIImage imageNamed:@"NSTexturedFullScreenBackgroundColor.png"]];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIViewController *orientationController = [[UIViewController alloc] init];
    
    CGFloat tempWidth = self.frame.size.width;
    CGFloat tempHeight = self.frame.size.height;
    
    if ((orientationController.interfaceOrientation == UIInterfaceOrientationLandscapeRight) ||
        (orientationController.interfaceOrientation == UIInterfaceOrientationLandscapeLeft))
    {
        if (self.frame.size.width < self.frame.size.height)
        {
            tempWidth = self.frame.size.height;
            tempHeight = self.frame.size.width;
        }
        
        [SQLayout layoutView:self.parallaxView1
              relativeToView:self
                   placement:SQPlaceWithin
                   alignment:SQAlignTop | SQAlignLeft
                   withWidth:tempWidth/2.0f
                  withHeight:tempHeight
                 withPadding:SQPaddingZero];
        
        [SQLayout layoutView:self.parallaxView2
              relativeToView:self.parallaxView1
                   placement:SQPlaceOnRight
                   alignment:SQAlignTop
                   withWidth:tempWidth/2.0f
                  withHeight:tempHeight
                 withPadding:SQPaddingZero];
    }
    else
    {
        if (self.frame.size.width > self.frame.size.height)
        {
            tempWidth = self.frame.size.height;
            tempHeight = self.frame.size.width;
        }
        
        [SQLayout layoutView:self.parallaxView1
              relativeToView:self
                   placement:SQPlaceWithin
                   alignment:SQAlignTop | SQAlignLeft
                   withWidth:tempWidth
                  withHeight:tempHeight/2.0f
                 withPadding:SQPaddingZero];
        
        [SQLayout layoutView:self.parallaxView2
              relativeToView:self.parallaxView1
                   placement:SQPlaceBelow
                   alignment:SQAlignLeft
                   withWidth:tempWidth
                  withHeight:tempHeight/2.0f
                 withPadding:SQPaddingZero];
    }
}

@end
