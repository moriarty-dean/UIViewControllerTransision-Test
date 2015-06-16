//
//  Transition.h
//  MovieTest
//
//  Created by kimteaksoo on 2015. 6. 13..
//  Copyright (c) 2015년 kimteaksoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ModalViewController.h"

@interface Transition : UIPercentDrivenInteractiveTransition <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning,
                                    UIViewControllerInteractiveTransitioning>

- (instancetype)initWithType:(ModalViewType)modalViewType;

@property (nonatomic, readwrite) id <UIViewControllerContextTransitioning> transitionContext;

- (void)cancelInteractiveTransitionWithDuration:(CGFloat)duration;
- (void)finishInteractiveTransitionWithDuration:(CGFloat)duration;

@end
