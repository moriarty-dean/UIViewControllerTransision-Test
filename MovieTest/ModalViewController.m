//
//  ModalViewController.m
//  MovieTest
//
//  Created by kimteaksoo on 2015. 6. 13..
//  Copyright (c) 2015년 kimteaksoo. All rights reserved.
//

#import "ModalViewController.h"
#import "Transition.h"
#import "ViewController.h"

@interface ModalViewController ()

@property (nonatomic, strong) Transition* transition;
@property (nonatomic) ModalViewType modalViewType;

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation ModalViewController

- (instancetype)initWithType:(ModalViewType)modalViewType {
    self = [super init];
    if (self) {
        self.modalViewType = modalViewType;
        
        self.transition = [[Transition alloc] initWithType:self.modalViewType];
        self.transitioningDelegate = self.transition;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    self.view.autoresizesSubviews = false;
    
    self.pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:self.pan];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer{
    
    if (recognizer.state==UIGestureRecognizerStateBegan){
        [self dismissViewControllerAnimated:YES completion:NULL];
        [recognizer setTranslation:CGPointZero inView:self.view.superview];
        [self.transition updateInteractiveTransition:0];
        return;
    }
    
    CGPoint point = [recognizer translationInView:self.view.superview];
    CGFloat percent = point.y / DISMISS_PIXEL_LENGHT;
    
    [self.transition updateInteractiveTransition:percent];
    
    NSTimeInterval duration = .35;
    
    if (recognizer.state==UIGestureRecognizerStateEnded) {
        BOOL cancel = false;
        

        if (point.y < DISMISS_PIXEL_LENGHT) {
            cancel = true;
        }
        
        if (cancel) {
            [self.transition cancelInteractiveTransitionWithDuration:duration];
        } else {
            [self.transition finishInteractiveTransitionWithDuration:duration];
        }
    }else if (recognizer.state==UIGestureRecognizerStateFailed){
        [self.transition cancelInteractiveTransitionWithDuration:duration];
    }
}

- (void)buttonPress:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
