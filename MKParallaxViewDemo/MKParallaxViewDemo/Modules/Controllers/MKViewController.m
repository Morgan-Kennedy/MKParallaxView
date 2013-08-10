//
//  MKViewController.m
//  MKParallaxViewDemo
//
//  Created by Morgan Kennedy on 21/07/13.
//  Copyright (c) 2013 Morgan Kennedy. All rights reserved.
//

#import "MKViewController.h"
#import "MKView.h"

#define mkView ((MKView *) [self view])

@interface MKViewController ()

@end

@implementation MKViewController

#pragma mark -
#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view = [[MKView alloc] initWithFrame:self.view.frame];
}

@end
