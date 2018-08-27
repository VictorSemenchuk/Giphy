//
//  DetailsViewController.m
//  Giphy
//
//  Created by Victor Macintosh on 25/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DetailsViewController.h"
#import "DetailsViewController+DetailsViewPresenterDelegate.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *trandingView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;

@property (nonatomic) DetailsViewPresenter *presenter;

- (void)setupData;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[DetailsViewPresenter alloc] initWithView:self];
    [self setupData];
}

- (void)setupData {
    self.title = @"GIF";
    
    CGFloat tempHeight = [self.giphyItem.image.preview.height floatValue];
    CGFloat tempWidth = [self.giphyItem.image.preview.width floatValue];
    self.imageViewHeightConstraint.constant = tempHeight * self.imageView.bounds.size.width / tempWidth;
    [self.presenter fetchOriginalImageForGiphyItem:self.giphyItem completion:^(UIImage * _Nullable image) {
        self.imageView.image = image;
    }];
    self.titleLabel.text = self.giphyItem.title;
    self.publishedLabel.text = [@"Published on " stringByAppendingString:[self.presenter convertDateWithInputDate:self.giphyItem.importDatetime]];
}

- (IBAction)share:(id)sender {
    [self.presenter shareGiphyItem:self.giphyItem image:self.imageView.image];
}


@end
