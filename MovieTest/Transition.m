
//
//  Transition.m
//  MovieTest
//
//  Created by kimteaksoo on 2015. 6. 13..
//  Copyright (c) 2015년 kimteaksoo. All rights reserved.
//

#import "Transition.h"
#import "ViewController.h"
#import "ModalViewController.h"

@interface Transition ()

@property (nonatomic) ModalViewType modalViewType;
@end

@implementation Transition

- (instancetype)initWithType:(ModalViewType)modalViewType {
    self = [super init];
    if (self) {
        self.modalViewType = modalViewType;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTrasition
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    ViewController* fromVC= (ViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ModalViewController* toVC= (ModalViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView* targetView;
    if (self.modalViewType == ModalViewTypeImage) {
        targetView = fromVC.imageView;
        toVC.imageView = (UIImageView*)targetView;
    } else if (self.modalViewType == ModalViewTypeMovie) {
        targetView = fromVC.playerView.view;
        toVC.playerView = fromVC.playerView;
    }
    
    toVC.view.frame = targetView.frame;
    targetView.frame = targetView.bounds;
    [toVC.view addSubview:targetView];
    [containerView addSubview:toVC.view];
    
    CGRect finalFrameOfToVc = [transitionContext finalFrameForViewController:toVC];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        targetView.frame = CGRectMake(0, 0, finalFrameOfToVc.size.width, finalFrameOfToVc.size.width);
        toVC.view.frame = finalFrameOfToVc;
    } completion:^(BOOL finished) { 
        [transitionContext completeTransition:YES];
    }];
}

#pragma mark - UIViewControllerInteraction
- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext=transitionContext;
    
    UIView* containerView = [transitionContext containerView];
    
    UIView* fromVC= [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView* toVC= [transitionContext viewForKey:UITransitionContextToViewKey];
    
    [containerView addSubview:toVC];
    [containerView addSubview:fromVC];
}

#pragma mark - UIPercentDrivenInteractiveTransition
- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    if (percentComplete<0) {
        percentComplete=0;
    }
    
    UIViewController* fromViewController = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGFloat fromViewY = DISMISS_PIXEL_LENGHT * percentComplete;
    CGRect fromViewFrame = fromViewController.view.frame;
    fromViewFrame.origin = CGPointMake(0, fromViewY);
    fromViewController.view.frame = fromViewFrame;
}

- (void)cancelInteractiveTransitionWithDuration:(CGFloat)duration {
    ViewController* toViewController = (ViewController*)[self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ModalViewController* fromViewController = (ModalViewController*)[self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect finalFrameOfToVc = [self.transitionContext finalFrameForViewController:fromViewController];
    
    [UIView animateWithDuration:duration animations:^{
        if (self.modalViewType == ModalViewTypeImage) {
            fromViewController.imageView.frame = CGRectMake(0, 0, finalFrameOfToVc.size.width, finalFrameOfToVc.size.width);
            fromViewController.view.frame = finalFrameOfToVc;
        } else if (self.modalViewType == ModalViewTypeMovie) {
            fromViewController.playerView.view.frame = CGRectMake(0, 0, finalFrameOfToVc.size.width, finalFrameOfToVc.size.width);
            fromViewController.view.frame = finalFrameOfToVc;
        }
    } completion:^(BOOL finished) {
        [toViewController.view removeFromSuperview];
        [self.transitionContext cancelInteractiveTransition];
        [self.transitionContext completeTransition:NO];
        self.transitionContext=nil;
    }];
}

- (void)finishInteractiveTransitionWithDuration:(CGFloat)duration {
    ViewController* toViewController = (ViewController*)[self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ModalViewController* fromViewController = (ModalViewController*)[self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [UIView animateWithDuration:duration animations:^{
        if (self.modalViewType == ModalViewTypeImage) {
            fromViewController.imageView.frame = toViewController.imageFrame;
            fromViewController.view.frame = toViewController.imageFrame;
        } else if (self.modalViewType == ModalViewTypeMovie) {
            CGRect frame = toViewController.playerFrame;
            frame.origin = CGPointMake(0, 0);
            fromViewController.playerView.view.frame = frame;
            fromViewController.view.frame = toViewController.playerFrame;
        }
    } completion:^(BOOL finished) {
        if (self.modalViewType == ModalViewTypeImage) {
            [toViewController.view addSubview:fromViewController.imageView];
        } else if (self.modalViewType == ModalViewTypeMovie) {
            fromViewController.playerView.view.frame = toViewController.playerFrame;
            [toViewController.view addSubview:fromViewController.playerView.view];
        }
        
        [fromViewController.view removeFromSuperview];
        [self.transitionContext completeTransition:YES];
        self.transitionContext=nil;
    }];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return  nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return self;
}

@end
