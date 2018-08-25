//
//  SearchResultsViewController.m
//  Giphy
//
//  Created by Victor Macintosh on 25/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "SearchResultsViewController+GiphyCollectionViewLayout.h"

@interface SearchResultsViewController ()

@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GiphyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
    GiphyCollectionViewLayout *layout = (GiphyCollectionViewLayout *)self.collectionView.collectionViewLayout;
    if (layout != nil) {
        layout.delegate = self;
    }
}

@end
