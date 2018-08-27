//
//  SearchResultsViewController.m
//  Giphy
//
//  Created by Victor Macintosh on 25/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "SearchResultsViewController+GiphyCollectionViewLayout.h"
#import "SearchResultsViewController+SearchResultsViewPresenterDelegate.h"

@interface SearchResultsViewController ()

@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items = [[NSMutableArray alloc] init];
    self.presenter = [[SearchResultsViewPresenter alloc] initWithView:self];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GiphyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
    self.collectionView.contentInset = UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0);
    GiphyCollectionViewLayout *layout = (GiphyCollectionViewLayout *)self.collectionView.collectionViewLayout;
    if (layout != nil) {
        layout.delegate = self;
    }
    [self.presenter setTitleWithText:self.searchRequest];

    [self.presenter fetchItemsBySearchRequest:self.searchRequest with:0];
}

@end
