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

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *trandingView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *imageContainerView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (nonatomic) DetailsViewPresenter *presenter;

- (void)setupData;
- (void)enableControls;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[DetailsViewPresenter alloc] initWithView:self];
    [self setupData];
}

- (void)setupData {
    self.title = @"GIF";
    
    self.imageContainerView.backgroundColor = [UIColor randomThemeColor];
    [self.activityIndicator startAnimating];
    
    CGFloat tempHeight = [self.giphyItem.image.preview.height floatValue];
    CGFloat tempWidth = [self.giphyItem.image.preview.width floatValue];
    self.imageViewHeightConstraint.constant = tempHeight * self.imageView.bounds.size.width / tempWidth;
    if ([self.presenter checkIfItemExists:self.giphyItem]) {
        [self.presenter setSavingStatus:YES];
        self.imageView.image = [self.presenter getExistingImage:self.giphyItem];
        [self.activityIndicator stopAnimating];
        [self enableControls];
    } else {
        [self.presenter setSavingStatus:NO];
        [self.presenter fetchOriginalImageForGiphyItem:self.giphyItem completion:^(UIImage * _Nullable image) {
            [self.activityIndicator stopAnimating];
            self.imageView.image = image;
            [self enableControls];
        }];
    }
    self.titleLabel.text = self.giphyItem.title;
    self.publishedLabel.text = [@"Published on " stringByAppendingString:[self.presenter convertDateWithInputDate:self.giphyItem.importDatetime]];
    self.trandingView.hidden = [self.giphyItem.trendingDatetime isEqualToString:@"0000-00-00 00:00:00"];
}

- (void)enableControls {
    self.saveButton.enabled = YES;
    self.shareButton.enabled = YES;
    self.stopPlayButton.enabled = YES;
    [self.stopPlayButton setImage:[UIImage imageNamed:@"StopIcon"] forState:UIControlStateNormal];
}

- (IBAction)share:(id)sender {
    [self.presenter shareGiphyItem:self.giphyItem image:self.imageView.image];
}

- (IBAction)stopPlay:(id)sender {
    [self.presenter stopPlayWithImageView:self.imageView];
}

- (IBAction)save:(id)sender {
    if (self.presenter.isSaved) {
        [self.presenter removeItem:self.giphyItem];
    } else {
        [self.presenter saveGiphyItem:self.giphyItem];
    }
    [self.presenter toggleSavingStatus];
}

@end
