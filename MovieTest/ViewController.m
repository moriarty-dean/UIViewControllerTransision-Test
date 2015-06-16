//
//  ViewController.m
//  MovieTest
//
//  Created by kimteaksoo on 2015. 6. 12..
//  Copyright (c) 2015년 kimteaksoo. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"
#import "Transition.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (nonatomic, strong) Transition* transition;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.imageView.image = [UIImage imageNamed:@"nimo.jpg"];
    [self.view addSubview:self.imageView];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"sosi" ofType:@"mp4"];
    self.playerView = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:path]];
    [self.playerView.view setFrame:CGRectMake(self.view.frame.size.width - 150, 0, 150, 150)];
    self.playerView.moviePlayer.controlStyle = MPMovieControlStyleNone;
    [self.playerView.moviePlayer play];
    [self.view addSubview:self.playerView.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)pressedImageButton:(id)sender {
    self.imageFrame = self.imageView.frame;
    
    ModalViewController* modal = [[ModalViewController alloc] initWithType:ModalViewTypeImage];
    
    [self presentViewController:modal animated:YES completion:nil];
}

- (IBAction)pressedMovieButton:(id)sender {
    self.playerFrame = self.playerView.view.frame;
    
    ModalViewController* modal = [[ModalViewController alloc] initWithType:ModalViewTypeMovie];
    modal.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:modal animated:YES completion:nil];
}

@end
