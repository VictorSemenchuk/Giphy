//
//  SearchResultsViewController.m
//  Giphy
//
//  Created by Victor Macintosh on 25/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "SearchResultsViewController+GiphyCollectionViewLayout.h"
#import "SearchResultsViewController+SearchResultsViewProtocol.h"
#import "DetailsViewController.h"
#import "Giphy-Swift.h"

@interface SearchResultsViewController ()

@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GiphyCollectionViewLayout *layout = (GiphyCollectionViewLayout *)self.collectionView.collectionViewLayout;
    if (layout != nil) {
        layout.delegate = self;
    }
    
    self.presenter = [[SearchResultsViewPresenter alloc] init];
    [self.presenter registerCellsFor:self.collectionView];
    [self.presenter setSearchRequest:self.searchRequest by:self];
    self.collectionView.dataSource = self.presenter;
    self.collectionView.contentInset = UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0);
    [self.presenter fetchItems:self.searchRequest with:0 for:self.collectionView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kDetailsSegueIdentifier]) {
        DetailsViewController *detailVC = segue.destinationViewController;
        NSIndexPath *indexPath = sender;
        detailVC.presenter = [[DetailsViewPresenter alloc] initWith:self.presenter.items[indexPath.row]];
    }
}

@end
