//
//  TbCustomSegue.m
//  Tagesbericht
//
//  Created by BigNerd on 24.05.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbCustomSegue.h"

@implementation TbCustomSegue

- (void)perform
{
//    [UIView beginAnimations:@"egal" context:nil];
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp
//                           forView:[[self sourceViewController] view] cache:NO];
//    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    [UIView commitAnimations];
    
    UIView *fromView = [[self sourceViewController] view];
    UIView *toView = [[self destinationViewController] view];
    UIView *containerView = [fromView superview];
    
    [UIView transitionWithView:containerView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{ [fromView removeFromSuperview]; [containerView addSubview:toView]; }
                    completion:^(BOOL finished) {
        [[[self sourceViewController] navigationController] pushViewController:[self destinationViewController] animated:NO];
                    }];
}

@end
