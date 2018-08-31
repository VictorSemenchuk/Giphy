//
//  SearchResultsViewController.h
//  Giphy
//
//  Created by Victor Macintosh on 25/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiphyCollectionViewLayout.h"
#import "GiphyCollectionViewCell.h"
#import "IdentifierConstants.h"

@protocol SearchResultsViewProtocol <NSObject>

- (void)setViewTitle:(NSString *)title;

@end

@class SearchResultsViewPresenter;
@interface SearchResultsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic) NSString *searchRequest;
@property (nonatomic) SearchResultsViewPresenter *presenter;

@end
