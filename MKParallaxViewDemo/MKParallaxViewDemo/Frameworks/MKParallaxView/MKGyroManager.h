//
//  MKGyroManager.h
//  MKParallaxViewDemo
//
//  Created by Morgan Kennedy on 20/07/13.
//  Copyright (c) 2013 Morgan Kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This is a singleton instance of the gyroscope manager who's
 main purpose is to consistantly notify the app of the
 x, y, z, roll, pitch, & yaw information
 */
@class MKGyroManager;

@protocol MKGyroManagerDelegate <NSObject>

@optional
/**
 Triggers each time the rotation rate values are updated
 @param x value as a double
 @param y value as a double
 @param z value as a double
 */
- (void)MKGyroManagerUpdatedX:(double)x Y:(double)y Z:(double)z;

/**
 Triggers each time the angles are calculated
 @param roll value as a float
 @param pitch value as a float
 @param yaw value as a float
 */
- (void)MKGyroManagerUpdatedRoll:(CGFloat)roll Pitch:(CGFloat)pitch Yaw:(CGFloat)yaw;

@end

@interface MKGyroManager : NSObject
/**
 The delegate to send the policy
 */
@property (nonatomic, weak) id<MKGyroManagerDelegate> delegate;

/**
 The last recorded Roll Value
 */
@property (nonatomic, assign) CGFloat roll;

/**
 The last recorded Pitch Value
 */
@property (nonatomic, assign) CGFloat pitch;

/**
 The last recorded Yaw Value
 */
@property (nonatomic, assign) CGFloat yaw;

/**
 Initialises the gyro manager as a singleton
 */
+ (MKGyroManager *)sharedGyroManager;

@end

/**
 Gives the same info in userInfo as - (void)MKGyroManagerUpdatedRoll:(CGFloat)roll Pitch:(CGFloat)pitch Yaw:(CGFloat)yaw;
 */
extern NSString *const MKGyroManagerUpdateAnglesNotification;