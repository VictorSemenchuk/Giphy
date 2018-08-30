//
//  DetailsViewController.m
//  Giphy
//
//  Created by Victor Macintosh on 25/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DetailsViewController.h"
#import "DetailsViewController+DetailsViewPresenterDelegate.h"
#import "UIColor+ThemeColors.h"
#import "Giphy-Swift.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *trandingView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *imageContainerView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

- (void)setupData;
- (void)enableControls;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
}

- (void)setupData {
    self.title = @"GIF";
    
    self.imageContainerView.backgroundColor = [UIColor randomThemeColor];
    [self.activityIndicator startAnimating];
    
    CGFloat tempHeight = [self.presenter.giphyItem.image.original.height floatValue];
    CGFloat tempWidth = [self.presenter.giphyItem.image.original.width floatValue];
    self.imageViewHeightConstraint.constant = tempHeight * (UIScreen.mainScreen.bounds.size.width - 20.0) / tempWidth;
    if ([self.presenter checkIfItemIsExists:self.presenter.giphyItem]) {
        [self.presenter setSavingStatus:YES by:self];
        self.imageView.image = [self.presenter getExistingImage:self.presenter.giphyItem];
        [self.activityIndicator stopAnimating];
        [self enableControls];
    } else {
        [self.presenter setSavingStatus:NO by:self];
        [self.presenter fetchOriginalImageForItem:self.presenter.giphyItem completion:^(UIImage * _Nullable image) {
            [self.activityIndicator stopAnimating];
            self.imageView.image = image;
            [self enableControls];
        }];
    }
    self.titleLabel.text = self.presenter.giphyItem.title;
    self.publishedLabel.text = [@"Published on " stringByAppendingString:[self.presenter convertDateWithInputDate:self.presenter.giphyItem.importDatetime]];
    self.trandingView.hidden = [self.presenter.giphyItem.trendingDatetime isEqualToString:@"0000-00-00 00:00:00"];
    [self.view setNeedsLayout];
}

- (void)enableControls {
    self.saveButton.enabled = YES;
    self.shareButton.enabled = YES;
    self.stopPlayButton.enabled = YES;
    [self.stopPlayButton setImage:[UIImage imageNamed:@"StopIcon"] forState:UIControlStateNormal];
}

- (IBAction)share:(id)sender {
    [self.presenter shareItem:self.presenter.giphyItem by:self];
}

- (IBAction)stopPlay:(id)sender {
    [self.presenter startStopPlayingFor:self.imageView by:self];
}

- (IBAction)save:(id)sender {
    if (self.presenter.isSaved) {
        [self.presenter removeItem:self.presenter.giphyItem];
    } else {
        [self.presenter saveItem:self.presenter.giphyItem];
    }
    [self.presenter toggleSavingStatusBy:self];
}

@end
