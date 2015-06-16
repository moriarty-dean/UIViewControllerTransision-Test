//
//  ViewController.h
//  MovieTest
//
//  Created by kimteaksoo on 2015. 6. 12..
//  Copyright (c) 2015년 kimteaksoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController

@property (nonatomic) CGRect imageFrame;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic) CGRect playerFrame;
@property (nonatomic, strong) MPMoviePlayerViewController *playerView;

- (IBAction)pressedImageButton:(id)sender;
- (IBAction)pressedMovieButton:(id)sender;
@end

