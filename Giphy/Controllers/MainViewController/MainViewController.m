//
//  MainViewController.m
//  Giphy
//
//  Created by Viktar Semianchuk on 8/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewController+GiphyCollectionViewLayout.h"
#import "MainViewController+Appearance.h"
#import "SearchResultsViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GiphyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
    GiphyCollectionViewLayout *layout = (GiphyCollectionViewLayout *)self.collectionView.collectionViewLayout;
    if (layout != nil) {
        layout.delegate = self;
    }
    [self setupViews];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSearchResultSegueIdentifier]) {
        SearchResultsViewController *searchVC = segue.destinationViewController;
        searchVC.title = @"Search request";
    }
}

@end
