//
//  MKParallaxManager.m
//  MKParallaxViewDemo
//
//  Created by Morgan Kennedy on 19/07/13.
//  Copyright (c) 2013 Morgan Kennedy. All rights reserved.
//

#import "MKParallaxManager.h"
#import "MKGyroManager.h"

#define zeroPointV 30.0f
#define maxV 60.0f
#define minV 0.0f
#define zeroPointH 0.0f
#define maxH 30.0f
#define minH -30.0f
#define sizePercentPadding 0.0163f

@interface MKParallaxManager()

@property (nonatomic, strong) UIViewController *orientationController;

/**
 Generates the current Frame based on the front facing angle and sideways tilt
 as well as the frame size
 */
- (CGRect)generateCurrentFrameUsingFrontAngle:(CGFloat)frontAngle SideTile:(CGFloat)sideTilt ViewFrame:(CGRect)viewFrame;

@end

@implementation MKParallaxManager

#pragma mark -
#pragma mark - Lifecycle Methods
+ (MKParallaxManager *)standardParallaxManager
{
    MKParallaxManager *standardParallaxManager = [[MKParallaxManager alloc] init];
    return standardParallaxManager;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [MKGyroManager sharedGyroManager];
        _orientationController = [[UIViewController alloc] init];
    }
    
    return self;
}

#pragma mark -
#pragma mark - Public Methods
- (CGRect)parallexFrameWithViewFrame:(CGRect)viewFrame
{
    CGFloat roll = [[MKGyroManager sharedGyroManager] roll];
    CGFloat pitch = [[MKGyroManager sharedGyroManager] pitch];
    
    CGFloat frontAngle = zeroPointV;
    CGFloat sideTilt = zeroPointH;
    
    if (self.orientationController.interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        frontAngle = roll * -1;
        sideTilt = pitch;
    }
    else if (self.orientationController.interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        frontAngle = roll;
        sideTilt = pitch * -1;
    }
    else if (self.orientationController.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        frontAngle = pitch * -1;
        sideTilt = roll * -1;
    }
    else // Portrait Assumption
    {
        frontAngle = pitch;
        sideTilt = roll;
    }
    
    if (frontAngle < 0)
    {
        frontAngle = frontAngle * -1;
    }
    
    if (frontAngle > maxV)
    {
        frontAngle = maxV;
    }
    else if (frontAngle < minV)
    {
        frontAngle = minV;
    }
    
    if (sideTilt > maxH)
    {
        sideTilt = maxH;
    }
    else if (sideTilt < minH)
    {
        sideTilt = minH;
    }
    
    return [self generateCurrentFrameUsingFrontAngle:frontAngle SideTile:sideTilt ViewFrame:viewFrame];
}

#pragma mark -
#pragma mark - Private Methods
- (CGRect)generateCurrentFrameUsingFrontAngle:(CGFloat)frontAngle SideTile:(CGFloat)sideTilt ViewFrame:(CGRect)viewFrame
{
    CGFloat widthSingleSidePadding = viewFrame.size.width * sizePercentPadding;
    CGFloat heightSingleSidePadding = viewFrame.size.height * sizePercentPadding;
    
    CGFloat newWidth = viewFrame.size.width + (widthSingleSidePadding * 2);
    CGFloat newHeight = viewFrame.size.height + (heightSingleSidePadding * 2);
    
    CGFloat newX = 0 - widthSingleSidePadding;
    CGFloat newY = 0;
    
    if (sideTilt > zeroPointH)
    {
        CGFloat rightTiltPercent = sideTilt / maxH;
        CGFloat shiftFromCenter = rightTiltPercent * widthSingleSidePadding;
        newX = newX - shiftFromCenter;
    }
    else if (sideTilt < zeroPointH)
    {
        CGFloat leftTiltPercent = sideTilt / minH;
        CGFloat shiftFromCenter = leftTiltPercent * widthSingleSidePadding;
        newX = newX + shiftFromCenter;
    }
    
    if (frontAngle > zeroPointV)
    {
        CGFloat topTiltPercent = frontAngle / maxH;
        CGFloat shiftFromCenter = topTiltPercent * heightSingleSidePadding;
        newY = newY - shiftFromCenter;
    }
    else if (frontAngle < zeroPointV)
    {
        CGFloat bottomTiltPercent = frontAngle / minH;
        CGFloat shiftFromCenter = bottomTiltPercent * heightSingleSidePadding;
        newY = newY + shiftFromCenter;
    }
    
    return CGRectMake(newX, newY, newWidth, newHeight);
}

@end
