//
//  GiphyCollectionViewCell.m
//  Giphy
//
//  Created by Victor Macintosh on 25/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "GiphyCollectionViewCell.h"
#import "SearchResultsViewController.h"
#import "UIColor+ThemeColors.h"
#import "Giphy-Swift.h"

@interface GiphyCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *trendingImage;

- (void)showTrendingIndicator;
- (void)hideTrendingIndicator;

@end

@implementation GiphyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)startActivityIndicator {
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void)stopActivityIndicator {
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}

- (void)setupViewsForGiphyItem:(GiphyData *)giphyItem sender:(NSObject *)sender {
    if ([sender isKindOfClass:SearchResultsViewController.class] && ![giphyItem.trendingDatetime isEqualToString:kTrendingDateFormat]) {
        self.trendingImage.hidden = NO;
    } else {
        self.trendingImage.hidden = YES;
    }
    self.backgroundColor = [UIColor randomThemeColor];
}

- (void)showTrendingIndicator {
    self.trendingImage.hidden = NO;
}

- (void)hideTrendingIndicator {
    self.trendingImage.hidden = YES;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = [[UIImage alloc] init];
    self.trendingImage.hidden = YES;
    [self startActivityIndicator];
}

@end
