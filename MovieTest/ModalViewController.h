//
//  ModalViewController.h
//  MovieTest
//
//  Created by kimteaksoo on 2015. 6. 13..
//  Copyright (c) 2015년 kimteaksoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

#define DISMISS_PIXEL_LENGHT    50

typedef enum ModalViewType : NSInteger {
    ModalViewTypeImage,
    ModalViewTypeMovie
} ModalViewType;

@interface ModalViewController : UIViewController

@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) MPMoviePlayerViewController *playerView;

- (instancetype)initWithType:(ModalViewType)modalViewType;
- (void)buttonPress:(id)sender;
@end
