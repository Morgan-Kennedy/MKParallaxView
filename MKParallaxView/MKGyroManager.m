//
//  MKGyroManager.m
//  MKParallaxViewDemo
//
//  Created by Morgan Kennedy on 20/07/13.
//  Copyright (c) 2013 Morgan Kennedy. All rights reserved.
//

#import "MKGyroManager.h"
#import <CoreMotion/CoreMotion.h>

#define defaultHertz 1.0f/60.0f
#define defaultGyroUpdateInterval 0.1f

#define degrees(x) ((180 * x) / M_PI)

@interface MKGyroManager()

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSTimer *timer;

/**
 Calculates the angles in degrees of the device and fires
 the delegate and a notification with the information
 */
- (void)retrieveAngles;

@end

@implementation MKGyroManager

#pragma mark -
#pragma mark - Lifecycle Methods
+ (MKGyroManager *)sharedGyroManager
{
    static MKGyroManager *sharedGyroManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGyroManager = [[MKGyroManager alloc] init];
    });
    return sharedGyroManager;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = defaultHertz;
        [_motionManager startDeviceMotionUpdates];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:defaultHertz
                                                  target:self
                                                selector:@selector(retrieveAngles)
                                                userInfo:nil
                                                 repeats:YES];
    }
    
    return self;
}

#pragma mark - 
#pragma mark - Private Methods
- (void)retrieveAngles
{
    CMDeviceMotion *motion = self.motionManager.deviceMotion;
    CMAttitude *attitude = motion.attitude;
    
    self.roll = degrees(attitude.roll);
    self.pitch = degrees(attitude.pitch);
    self.yaw = degrees(attitude.yaw);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MKGyroManagerUpdatedRoll:Pitch:Yaw:)])
    {
        [self.delegate MKGyroManagerUpdatedRoll:self.roll Pitch:self.pitch Yaw:self.yaw];
    }
    
    NSDictionary *userInfo = @{@"roll":[NSNumber numberWithFloat:self.roll],
                               @"pitch":[NSNumber numberWithFloat:self.pitch],
                               @"yaw":[NSNumber numberWithFloat:self.yaw]};
    [[NSNotificationCenter defaultCenter] postNotificationName:MKGyroManagerUpdateAnglesNotification object:self userInfo:userInfo];
}

@end

NSString *const MKGyroManagerUpdateAnglesNotification = @"MKGyroManagerUpdateAnglesNotification";
