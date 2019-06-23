//
//  FLPhotoViewCell.m
//  Flipr
//
//  Created by Adem Atalay on 22.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLPhotoViewCell.h"
#import "FLDataGathering.h"
#import "FLResultsModel.h"
#import "FLTask.h"

@interface FLPhotoViewCell()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIActivityIndicatorView *loadingView;
@property (nonatomic) FLTask *currentTask;

@end

@implementation FLPhotoViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.loadingView];
        [self setupContraints];
    }
    return self;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.layer.cornerRadius = 4;
    }
    return _imageView;
}

- (UIActivityIndicatorView *)loadingView {
    if (!_loadingView) {
        _loadingView = UIActivityIndicatorView.new;
        _loadingView.translatesAutoresizingMaskIntoConstraints = NO;
        _loadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    return _loadingView;
}

- (void)setupContraints {
    [NSLayoutConstraint activateConstraints:@[
                                              [self.contentView.topAnchor constraintEqualToAnchor:self.imageView.topAnchor],
                                              [self.contentView.bottomAnchor constraintEqualToAnchor:self.imageView.bottomAnchor],
                                              [self.contentView.leadingAnchor constraintEqualToAnchor:self.imageView.leadingAnchor],
                                              [self.contentView.trailingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor],
                                              [self.contentView.centerXAnchor constraintEqualToAnchor:self.loadingView.centerXAnchor],
                                              [self.contentView.centerYAnchor constraintEqualToAnchor:self.loadingView.centerYAnchor],
                                              ]];
}

- (void)configureWithViewModel:(FLPhotoModel *)viewModel
                  mediaService:(id<FLDataGathering>)mediaService {
    [self.currentTask cancel];
    self.imageView.image = nil;
    
    __weak FLPhotoViewCell *weakSelf = self;
    [self.loadingView startAnimating];
    self.currentTask = [mediaService dataWithModel:viewModel completion:^(UIImage *image, NSError *error) {
        __strong FLPhotoViewCell *strongSelf = weakSelf;
        strongSelf.imageView.image = image;
        [strongSelf.loadingView stopAnimating];
    }];
}

@end
